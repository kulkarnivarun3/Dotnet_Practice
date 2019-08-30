using System;
using System.Web.Security;
using System.Collections;
using System.Collections.Specialized;
using System.Xml;
using System.Web;
using System.Web.Caching;
using System.Text.RegularExpressions;
using System.Web.Hosting;
using System.IO;
using System.Text;
using System.Security.Cryptography;

namespace AspNetUnleashed
{

    /// <summary>
    /// Stores Membership information in an XML file
    /// </summary>
    public class XmlMembershipProvider : MembershipProvider
    {
        string _dataFile = "~/App_Data/Membership.xml";
        string _applicationName;
        bool _requiresQuestionAndAnswer = true;
        bool _enablePasswordRetrieval = false;
        bool _enablePasswordReset = true;
        bool _requiresUniqueEmail = false;
        MembershipPasswordFormat _passwordFormat = MembershipPasswordFormat.Clear;

        /// <summary>
        /// Read the configuration settings for the XmlMembershipProvider
        /// </summary>
        public override void Initialize(string name, NameValueCollection config)
        {
            if (!String.IsNullOrEmpty(config["applicationName"]))
                _applicationName = config["applicationName"];
            else
                _applicationName = HostingEnvironment.ApplicationVirtualPath;

            if (!String.IsNullOrEmpty(config["dataFile"]))
                _dataFile = config["dataFile"];
            if (!String.IsNullOrEmpty(config["requiresQuestionAndAnswer"]))
                _requiresQuestionAndAnswer = bool.Parse(config["requiresQuestionAndAnswer"]);
            if (!String.IsNullOrEmpty(config["enablePasswordRetrieval"]))
                _enablePasswordRetrieval = bool.Parse(config["enablePasswordRetrieval"]);
            if (!String.IsNullOrEmpty(config["enablePasswordReset"]))
                _enablePasswordReset = bool.Parse(config["enablePasswordReset"]);
            if (!String.IsNullOrEmpty(config["requiresUniqueEmail"]))
                _requiresUniqueEmail = bool.Parse(config["requiresUniqueEmail"]);
            if (!String.IsNullOrEmpty(config["passwordFormat"]))
                _passwordFormat = (MembershipPasswordFormat)Enum.Parse(typeof(MembershipPasswordFormat), config["passwordFormat"]);
            base.Initialize(name, config);
        }


        /// <summary>
        /// Retreive the XML file of users and cache it
        /// </summary>
        private XmlDocument GetXmlUsers()
        {
            XmlDocument xmlUsers = (XmlDocument)HostingEnvironment.Cache["Users"];
            if (xmlUsers == null)
            {
                // Load Users from XML document
                string absPath = HostingEnvironment.MapPath(_dataFile);
                EnsureXmlFile(absPath);
                xmlUsers = new XmlDocument();
                xmlUsers.Load(absPath);

                // Cache XML Document
                CacheDependency fileDepend = new CacheDependency(absPath);
                HostingEnvironment.Cache.Insert("Users", xmlUsers, fileDepend);
            }
            return xmlUsers;
        }

        /// <summary>
        /// Get a single user from the (cached) XML file
        /// </summary>
        private XmlElement GetXmlUser(XmlDocument users, string username)
        {
            foreach (XmlElement element in users.DocumentElement.ChildNodes)
            {
                if (element.Attributes["name"].Value == username)
                    return element;
            }
            return null;
        }

        /// <summary>
        /// Save XML file back to hard drive
        /// </summary>
        private void SaveXmlUsers(XmlDocument users)
        {
            Object lockThis = new Object();
            lock (lockThis)
            {
                users.Save(HostingEnvironment.MapPath(_dataFile));
            }
        }

        /// <summary>
        /// If XML file doesn't exist, create ite
        /// </summary>
        private void EnsureXmlFile(string path)
        {
            if (!File.Exists(path))
            {
                XmlDocument proto = new XmlDocument();
                proto.LoadXml("<credentials></credentials>");
                proto.Save(path);
            }
        }

        /// <summary>
        /// Utility method that converts an XML user element
        /// to a MembershipUser
        /// </summary>
        private MembershipUser CreateUserFromElement(XmlElement element)
        {
            // Required Attribute
            if (String.IsNullOrEmpty(element.Attributes["name"].Value))
                throw new Exception("user element missing name attribute");
            string username = element.Attributes["name"].Value;

            // Optional Attributes
            string email = String.Empty;
            if (element.HasAttribute("email"))
                email = element.Attributes["email"].Value;
            string passwordQuestion = String.Empty;
            if (element.HasAttribute("passwordQuestion"))
                passwordQuestion = element.Attributes["passwordQuestion"].Value;
            string comment = String.Empty;
            if (element.HasAttribute("comment"))
                passwordQuestion = element.Attributes["comment"].Value;
            bool isActive = true;
            if (element.HasAttribute("isActive"))
                isActive = bool.Parse(element.Attributes["isActive"].Value);
            bool isLockedOut = false;
            if (element.HasAttribute("isLockedOut"))
                isActive = bool.Parse(element.Attributes["isLockedOut"].Value);

            MembershipUser user = new MembershipUser(
                this.Name,
                username,
                username,
                email,
                passwordQuestion,
                comment,
                isActive,
                isLockedOut,
                DateTime.MinValue,
                DateTime.MinValue,
                DateTime.MinValue,
                DateTime.MinValue,
                DateTime.MinValue);
            return user;
        }

        /// <summary>
        /// The ApplicationName isn't really used since
        /// the XML file is stored in a particular application.
        /// </summary>
        public override string ApplicationName
        {
            get
            {
                return _applicationName;
            }
            set
            {
                _applicationName = value;
            }
        }

        /// <summary>
        /// Validate user name and password
        /// against XML file
        /// </summary>
        public override bool ValidateUser(string username, string password)
        {
            XmlDocument xmlUsers = GetXmlUsers();
            foreach (XmlElement element in xmlUsers.DocumentElement.ChildNodes)
            {
                if (element.Attributes["name"].Value == username && element.Attributes["password"].Value == CreatePassword(password))
                    return true;
            }
            return false;
        }

        /// <summary>
        /// Get the password for a particular user
        /// </summary>
        public override string GetPassword(string username, string answer)
        {
            if (!EnablePasswordRetrieval)
                throw new NotSupportedException("Retrieving passwords is not supported");

            if (_passwordFormat == MembershipPasswordFormat.Hashed)
                throw new System.Configuration.ConfigurationException("Can't retrieve hashed password");

            XmlDocument xmlUsers = GetXmlUsers();
            foreach (XmlElement element in xmlUsers.DocumentElement.ChildNodes)
            {
                if (element.Attributes["name"].Value == username)
                    return element.Attributes["password"].Value;
            }
            return null;
        }

        /// <summary>
        /// Add a new user element to the XML file
        /// </summary>
        public override MembershipUser CreateUser(string username, string password, string email, string passwordQuestion, string passwordAnswer, bool isApproved, object providerUserKey, out MembershipCreateStatus status)
        {
            XmlDocument xmlUsers = GetXmlUsers();

            // Check for duplicate username
            if (GetUser(username, true) != null)
            {
                status = MembershipCreateStatus.DuplicateUserName;
                return null;
            }

            // Check for duplicate email
            if (_requiresUniqueEmail)
            {
                if (GetUserNameByEmail(email) != null)
                {
                    status = MembershipCreateStatus.DuplicateEmail;
                    return null;
                }
            }

            XmlElement newUser = xmlUsers.CreateElement("user");
            newUser.SetAttribute("name", username);
            newUser.SetAttribute("password", CreatePassword(password));
            newUser.SetAttribute("email", email);

            if (!String.IsNullOrEmpty(passwordQuestion))
                newUser.SetAttribute("passwordQuestion", passwordQuestion);
            if (!String.IsNullOrEmpty(passwordAnswer))
                newUser.SetAttribute("passwordAnswer", passwordAnswer);
            if (!isApproved)
                newUser.SetAttribute("isApprovided", "false");

            xmlUsers.DocumentElement.AppendChild(newUser);
            SaveXmlUsers(xmlUsers);
            status = MembershipCreateStatus.Success;
            return CreateUserFromElement(newUser);
        }

        /// <summary>
        /// Update user element in XML file
        /// </summary>
        /// <param name="user"></param>
        public override void UpdateUser(MembershipUser user)
        {
            XmlDocument xmlUsers = GetXmlUsers();
            XmlElement xmlUser = GetXmlUser(xmlUsers, user.UserName);

            if (xmlUser != null)
            {
                xmlUser.SetAttribute("name", user.UserName);
                xmlUser.SetAttribute("email", user.Email);
                xmlUser.SetAttribute("isApproved", user.IsApproved.ToString());

                if (!String.IsNullOrEmpty(user.Comment))
                    xmlUser.SetAttribute("comment", user.Comment);


                if (!String.IsNullOrEmpty(user.PasswordQuestion))
                    xmlUser.SetAttribute("passwordQuestion", user.PasswordQuestion);
                SaveXmlUsers(xmlUsers);
            }
        }

        /// <summary>
        /// Hash, Encrypt, or leave the password alone depending
        /// on the passwordFormat setting
        /// </summary>
        private string CreatePassword(string password)
        {
            if (_passwordFormat == MembershipPasswordFormat.Hashed)
                password = FormsAuthentication.HashPasswordForStoringInConfigFile(password, "SHA1");
            return password;
        }

        /// <summary>
        /// Retrieve all user elements from XML file ignoring
        /// page index and page size
        /// </summary>
        public override MembershipUserCollection GetAllUsers(int pageIndex, int pageSize, out int totalRecords)
        {
            XmlDocument xmlUsers = GetXmlUsers();
            MembershipUserCollection colUsers = new MembershipUserCollection();
            foreach (XmlElement element in xmlUsers.DocumentElement.ChildNodes)
            {
                MembershipUser user = CreateUserFromElement(element);
                colUsers.Add(user);
            }
            totalRecords = colUsers.Count;
            return colUsers;
        }

        /// <summary>
        /// Return all users who have the specified email address
        /// </summary>
        public override MembershipUserCollection FindUsersByEmail(string emailToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            XmlDocument xmlUsers = GetXmlUsers();
            MembershipUserCollection colUsers = new MembershipUserCollection();
            foreach (XmlElement element in xmlUsers.DocumentElement.ChildNodes)
            {
                if (element.HasAttribute("email"))
                {
                    if (element.Attributes["email"].Value == emailToMatch)
                    {
                        MembershipUser user = CreateUserFromElement(element);
                        colUsers.Add(user);
                    }
                }
            }
            totalRecords = colUsers.Count;
            return colUsers;
        }

        /// <summary>
        /// Return all users who have the specified username
        /// </summary>
        public override MembershipUserCollection FindUsersByName(string usernameToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            XmlDocument xmlUsers = GetXmlUsers();
            MembershipUserCollection colUsers = new MembershipUserCollection();
            foreach (XmlElement element in xmlUsers.DocumentElement.ChildNodes)
            {
                if (element.Attributes["name"].Value == usernameToMatch)
                {
                    MembershipUser user = CreateUserFromElement(element);
                    colUsers.Add(user);
                }
            }
            totalRecords = colUsers.Count;
            return colUsers;
        }

        /// <summary>
        /// Change the user password
        /// </summary>
        public override bool ChangePassword(string username, string oldPassword, string newPassword)
        {
            XmlDocument users = GetXmlUsers();
            XmlElement user = GetXmlUser(users, username);
            if (user == null)
                return false;
            if (user.Attributes["password"].Value != CreatePassword(oldPassword))
                return false;
            user.SetAttribute("password", CreatePassword(newPassword));
            SaveXmlUsers(users);
            return true;
        }

        /// <summary>
        /// Change the user password question and answer
        /// </summary>
        public override bool ChangePasswordQuestionAndAnswer(string username, string password, string newPasswordQuestion, string newPasswordAnswer)
        {
            XmlDocument users = GetXmlUsers();
            XmlElement user = GetXmlUser(users, username);
            if (user == null)
                return false;
            if (user.Attributes["password"].Value != CreatePassword(password))
                return false;
            user.SetAttribute("passwordQuestion", newPasswordQuestion);
            user.SetAttribute("passwordAnswer", newPasswordAnswer);
            SaveXmlUsers(users);
            return true;
        }

        /// <summary>
        /// Reset password to a randomly generated password
        /// </summary>
        public override string ResetPassword(string username, string answer)
        {
            if (!_requiresQuestionAndAnswer)
                throw new NotSupportedException("Reset password not supported when requiresQuestionAndAnswer is false.");

            XmlDocument users = GetXmlUsers();
            XmlElement user = GetXmlUser(users, username);
            if (user == null)
                throw new Exception("User not found");

            if (user.Attributes["passwordAnswer"].Value != answer)
                throw new Exception("Invalid answer");

            string newPassword = Membership.GeneratePassword(15, 1);
            user.SetAttribute("password", CreatePassword(newPassword));
            SaveXmlUsers(users);
            return newPassword;
        }


        /// <summary>
        /// Get a single user from the cached XML file
        /// </summary>
        public override MembershipUser GetUser(string username, bool userIsOnline)
        {
            XmlDocument users = GetXmlUsers();
            foreach (XmlElement element in users.DocumentElement.ChildNodes)
            {
                if (element.Attributes["name"].Value == username)
                    return CreateUserFromElement(element);
            }
            return null;
        }


        /// <summary>
        /// Get a single user by provider key.
        /// This provider just calls the GetUser() method
        /// and pretends that the user name is a key
        /// </summary>
        /// <returns></returns>
        public override MembershipUser GetUser(object providerUserKey, bool userIsOnline)
        {
            return GetUser(providerUserKey, true);
        }

        /// <summary>
        /// Return the user name that matches an email address
        /// </summary>
        public override string GetUserNameByEmail(string email)
        {
            XmlDocument users = GetXmlUsers();

            foreach (XmlElement element in users.DocumentElement.ChildNodes)
            {
                if (element.Attributes["email"].Value == email)
                    return element.Attributes["name"].Value;
            }
            return null;
        }


        public override bool DeleteUser(string username, bool deleteAllRelatedData)
        {
            XmlDocument users = GetXmlUsers();
            foreach (XmlNode node in users.DocumentElement.ChildNodes)
            {
                if (node.Attributes["name"].Value == username)
                {
                    node.ParentNode.RemoveChild(node);
                    SaveXmlUsers(users);
                    return true;
                }
            }
            return false;
        }

        /// <summary>
        /// This setting is read from the config file
        /// </summary>
        public override bool RequiresQuestionAndAnswer
        {
            get { return _requiresQuestionAndAnswer; }
        }

        /// <summary>
        /// This setting is read from the config file
        /// </summary>
        public override bool EnablePasswordReset
        {
            get { return _enablePasswordReset; }
        }

        /// <summary>
        /// This setting is read from the config file
        /// </summary>
        public override bool EnablePasswordRetrieval
        {
            get
            {
                if (_passwordFormat == MembershipPasswordFormat.Hashed && _enablePasswordRetrieval)
                    throw new Exception("Retrieving passwords not supported when hashed");

                return _enablePasswordRetrieval;
            }
        }

        /// <summary>
        /// This setting is read from the config file
        /// </summary>
        public override MembershipPasswordFormat PasswordFormat
        {
            get { return _passwordFormat; }
        }

        /// <summary>
        /// Don't require a unique email
        /// </summary>
        public override bool RequiresUniqueEmail
        {
            get { return false; }
        }

        public override int MinRequiredNonAlphanumericCharacters
        {
            get { return 0; }
        }

        public override int MinRequiredPasswordLength
        {
            get { return 1; }
        }



        /// 
        /// The following methods are not implemented to prevent
        /// excessive writing to the XML file
        /// 

        public override int GetNumberOfUsersOnline()
        {
            throw new Exception("The method or operation is not implemented.");
        }

        public override int MaxInvalidPasswordAttempts
        {
            get { throw new Exception("The method or operation is not implemented."); }
        }

 
        public override int PasswordAttemptWindow
        {
            get { throw new Exception("The method or operation is not implemented."); }
        }

        public override string PasswordStrengthRegularExpression
        {
            get { throw new Exception("The method or operation is not implemented."); }
        }

        public override bool UnlockUser(string userName)
        {
            throw new Exception("The method or operation is not implemented.");
        }

    }
}