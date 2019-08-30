using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Profile;
using System.Collections.Specialized;
using System.Web.Configuration;
using System.Web.Hosting;

/*

This provider assumes the existence of the following Profiles table:

CREATE TABLE Profiles
(
  UniqueID IDENTITY NOT NULL PRIMARY KEY,
  UserName NVarchar(255) NOT NULL,
  ApplicationName NVarchar(255) NOT NULL,
  IsAnonymous BIT, 
  LastActivityDate DateTime,
  LastUpdatedDate DateTime,
)

Profile data is stored in a table named ProfileData. This table must
include a column named ProfileID. The remaining columns correspond
to the profile properties that you define in the Web.Config file.
  
  
CREATE TABLE ProfileData
{
  ProfileID INT,
  ProfileProp1,
  ProfileProp2,
  ProfileProp3, ...
}  
  
  
*/


namespace AspNetUnleashed
{

    /// <summary>
    /// Enables you to store profile properties in different 
    /// database table columns
    /// </summary>
    public class BetterProfileProvider : ProfileProvider
    {
        private string _applicationName;
        private string _connectionString;
        private string _profileTableName = "ProfileData";

        /// <summary>
        /// We need configuration stuff like the connection string and
        /// name of the table in which to store profile data
        /// </summary>
        public override void Initialize(string name, NameValueCollection config)
        {
            // Get the Application Name
            _applicationName = HostingEnvironment.ApplicationVirtualPath;
            if (!String.IsNullOrEmpty(config["applicationName"]))
                _applicationName = (string)config["applicationName"];

            // Get the connection string
            if (String.IsNullOrEmpty(config["connectionStringName"]))
                throw new ConfigurationException("You must specify a connectionStringName");
            string connectionStringName = (string)config["connectionStringName"];
            ConnectionStringSettings connection = WebConfigurationManager.ConnectionStrings[connectionStringName];
            if (connection == null)
                throw new ConfigurationException("Could not find connection string " + connectionStringName);
            _connectionString = connection.ConnectionString;


            // Get the Profile Table Name
            if (!String.IsNullOrEmpty(config["profileTableName"]))
                _profileTableName = (string)config["profileTableName"];

            base.Initialize(name, config);
        }


        public override SettingsPropertyValueCollection GetPropertyValues(SettingsContext context, SettingsPropertyCollection collection)
        {
            SettingsPropertyValueCollection results = new SettingsPropertyValueCollection();
            foreach (SettingsProperty prop in collection)
                results.Add(new SettingsPropertyValue(prop));

            // Get Settings
            string userName = (string)context["UserName"];
            bool isAuthenticated = (bool)context["IsAuthenticated"];

            // Build Command Text
            string commandText = String.Format("SELECT profileData.* FROM Profiles INNER JOIN {0} AS profileData ON UniqueID=ProfileID WHERE Username=@Username AND ApplicationName=@ApplicationName AND IsAnonymous=@IsAnonymous", _profileTableName);

            // Execute command
            SqlDataAdapter dad = new SqlDataAdapter(commandText, _connectionString);
            dad.SelectCommand.Parameters.AddWithValue("@Username", userName);
            dad.SelectCommand.Parameters.AddWithValue("@ApplicationName", _applicationName);
            dad.SelectCommand.Parameters.AddWithValue("@IsAnonymous", !isAuthenticated);
            using (dad)
            {
                DataTable tblResults = new DataTable();
                dad.Fill(tblResults);
                if (tblResults.Rows.Count > 0)
                {
                    foreach (SettingsPropertyValue prop in results)
                    {
                        if (tblResults.Columns.Contains(prop.Name))
                        {
                            prop.PropertyValue = tblResults.Rows[0][prop.Name];
                        }
                    }
                }

            }
            UpdateActivityDates(userName, isAuthenticated, true);

            return results;
        }

        public override void SetPropertyValues(SettingsContext context, SettingsPropertyValueCollection collection)
        {
            // Get Settings
            string userName = (string)context["UserName"];
            bool isAuthenticated = (bool)context["IsAuthenticated"];

            // Get Profile ID
            int profileID = GetProfileID(userName, isAuthenticated, false);
            if (profileID == 0)
                profileID = CreateProfile(userName, isAuthenticated);

            // Dynamically build command text
            List<String> colColumns = new List<string>();
            List<String> colValues = new List<string>();
            foreach (SettingsPropertyValue pv in collection)
            {
                colColumns.Add(pv.Property.Name);
                colValues.Add("@" + pv.Property.Name);
            }
            string[] arrColumns = colColumns.ToArray();
            string columnList = String.Join(",", arrColumns);
            string[] arrValues = colValues.ToArray();
            string ValueList = String.Join(",", arrValues);
            string commandText = String.Format("INSERT {0} (ProfileID,{1}) VALUES (@ProfileID,{2})", _profileTableName, columnList, ValueList);


            // Create command
            SqlConnection con = new SqlConnection(_connectionString);
            SqlCommand cmd = new SqlCommand(commandText, con);


            // Build parameters
            cmd.Parameters.AddWithValue("@ProfileID", profileID);
            foreach (string col in arrColumns)
            {
                cmd.Parameters.AddWithValue("@" + col, collection[col].PropertyValue);
            }

            // Create delete command
            string deleteCommandText = String.Format("DELETE {0} WHERE ProfileID=@ProfileID", _profileTableName);
            SqlCommand cmdDelete = new SqlCommand(deleteCommandText, con);
            cmdDelete.Parameters.AddWithValue("@ProfileID", profileID);

            // Execute the commands (transactionally)
            SqlTransaction tran = null;
            try
            {
                con.Open();
                tran = con.BeginTransaction();
                cmdDelete.Transaction = tran;
                cmd.Transaction = tran;
                cmdDelete.ExecuteNonQuery();
                cmd.ExecuteNonQuery();
                tran.Commit();
            }
            catch
            {
                tran.Rollback();
            }
            finally
            {
                con.Close();
            }

            UpdateActivityDates(userName, isAuthenticated, true);
        }


        private int GetProfileID(string userName, bool isAuthenticated, bool ignoreAuthentication)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(_connectionString);
            SqlCommand cmd = new SqlCommand("SELECT UniqueID FROM Profiles WHERE UserName=@UserName AND ApplicationName=@ApplicationName", con);
            cmd.Parameters.AddWithValue("@UserName", userName);
            cmd.Parameters.AddWithValue("@ApplicationName", _applicationName);

            if (!ignoreAuthentication)
            {
                cmd.CommandText += " AND IsAnonymous=@IsAnonymous";
                cmd.Parameters.AddWithValue("@IsAnonymous", !isAuthenticated);
            }

            using (con)
            {
                con.Open();
                object dbResult = cmd.ExecuteScalar();
                if (dbResult != null)
                    result = (int)dbResult;
            }
            return result;
        }


        private int CreateProfile(string userName, bool isAuthenticated)
        {
            int result = 0;

            // Check for valid user name.
            if (userName == null)
                throw new ArgumentNullException("User name cannot be null.");
            if (userName.Length > 255)
                throw new ArgumentException("User name exceeds 255 characters.");
            if (userName.IndexOf(",") > 0)
                throw new ArgumentException("User name cannot contain a comma (,).");

            // Create command to add profile
            SqlConnection con = new SqlConnection(_connectionString);
            SqlCommand cmd = new SqlCommand("INSERT Profiles (UserName,ApplicationName,IsAnonymous,LastActivityDate,LastUpdatedDate) VALUES (@UserName,@ApplicationName,@IsAnonymous,@LastActivityDate,@LastUpdatedDate)", con);
            cmd.Parameters.AddWithValue("@UserName", userName);
            cmd.Parameters.AddWithValue("@ApplicationName", _applicationName);
            cmd.Parameters.AddWithValue("@IsAnonymous", !isAuthenticated);
            cmd.Parameters.AddWithValue("@LastActivityDate", DateTime.Now);
            cmd.Parameters.AddWithValue("@LastUpdatedDate", DateTime.Now);


            // Create command to get profile identity
            SqlCommand cmd2 = new SqlCommand("SELECT @@IDENTITY", con);

            using (con)
            {
                con.Open();
                cmd.ExecuteNonQuery();
                result = (int)(decimal)cmd2.ExecuteScalar();
            }
            return result;
        }



        private void UpdateActivityDates(string username, bool isAuthenticated, bool activityOnly)
        {
            SqlConnection con = new SqlConnection(_connectionString);
            SqlCommand cmd = con.CreateCommand();


            if (activityOnly)
            {
                cmd.CommandText = "UPDATE Profiles SET LastActivityDate=GetDate() WHERE UserName=@UserName AND ApplicationName=@ApplicationName AND IsAnonymous=@IsAnonymous";
            }
            else
            {
                cmd.CommandText = "UPDATE Profiles SET LastActivityDate=GetDate(),LastUpdatedDate=GetDate() WHERE UserName=@UserName AND ApplicationName=@ApplicationName AND IsAnonymous=@IsAnonymous";
            }

            // Add Parameters
            cmd.Parameters.AddWithValue("@UserName", username);
            cmd.Parameters.AddWithValue("@ApplicationName", _applicationName);
            cmd.Parameters.AddWithValue("@IsAnonymous", !isAuthenticated);

            using (con)
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public override int DeleteInactiveProfiles(ProfileAuthenticationOption authenticationOption, DateTime userInactiveSinceDate)
        {
            SqlConnection con = new SqlConnection(_connectionString);
            SqlCommand cmd = new SqlCommand("SELECT Username FROM Profiles WHERE ApplicationName = @ApplicationName AND LastActivityDate <= @LastActivityDate", con);
            cmd.Parameters.AddWithValue("@ApplicationName", ApplicationName);
            cmd.Parameters.AddWithValue("@LastActivityDate", userInactiveSinceDate);

            switch (authenticationOption)
            {
                case ProfileAuthenticationOption.Anonymous:
                    cmd.CommandText += " AND IsAnonymous = @IsAnonymous";
                    cmd.Parameters.AddWithValue("@IsAnonymous", true);
                    break;
                case ProfileAuthenticationOption.Authenticated:
                    cmd.CommandText += " AND IsAnonymous = @IsAnonymous";
                    cmd.Parameters.AddWithValue("@IsAnonymous", false);
                    break;
                default:
                    break;
            }

            SqlDataReader reader = null;
            string usernames = String.Empty;

            using (con)
            {
                con.Open();
                reader = cmd.ExecuteReader();
                while (reader.Read())
                    usernames += (string)reader["UserName"] + ",";
            }

            if (usernames.Length > 0)
            {
                // Remove trailing comma.
                usernames = usernames.Substring(0, usernames.Length - 1);
            }


            // Delete profiles.
            return DeleteProfiles(usernames.Split(','));
        }

        public override int DeleteProfiles(string[] usernames)
        {
            int deleteCount = 0;

            SqlConnection con = new SqlConnection(_connectionString);
            SqlTransaction tran = null;

            try
            {
                con.Open();
                tran = con.BeginTransaction();
                foreach (string userName in usernames)
                {
                    if (DeleteProfile(userName, con, tran))
                        deleteCount++;
                }
                tran.Commit();
            }
            catch
            {
                tran.Rollback();
            }
            finally
            {
                con.Close();
            }

            return deleteCount;
        }

        public override int DeleteProfiles(ProfileInfoCollection profiles)
        {
            List<string> colProfiles = new List<string>();
            foreach (ProfileInfo p in profiles)
                colProfiles.Add(p.UserName);
            return DeleteProfiles(colProfiles.ToArray());
        }




        private bool DeleteProfile(string userName, SqlConnection con, SqlTransaction tran)
        {
            int profileID = GetProfileID(userName, false, true);

            // Create commands
            SqlCommand cmd = new SqlCommand("DELETE Profiles WHERE UniqueID=@ProfileID", con);
            string deleteCommandText = String.Format("DELETE {0} WHERE ProfileID=@ProfileID", _profileTableName);
            SqlCommand cmd2 = new SqlCommand(deleteCommandText, con);

            // Enroll in transaction
            cmd.Transaction = tran;
            cmd2.Transaction = tran;

            // Add Parameters
            cmd.Parameters.AddWithValue("@ProfileID", profileID);
            cmd2.Parameters.AddWithValue("@ProfileID", profileID);

            int numDeleted = 0;

            numDeleted += cmd.ExecuteNonQuery();
            numDeleted += cmd2.ExecuteNonQuery();

            if (numDeleted > 0)
                return true;
            else
                return false;
        }




        private void CheckPageParameters(int pageIndex, int pageSize)
        {
            if (pageIndex < 0)
                throw new ArgumentException("Page index must 0 or greater.");
            if (pageSize < 1)
                throw new ArgumentException("Page size must be greater than 0.");
        }




        public override ProfileInfoCollection FindInactiveProfilesByUserName(ProfileAuthenticationOption authenticationOption, string usernameToMatch, DateTime userInactiveSinceDate, int pageIndex, int pageSize, out int totalRecords)
        {
            CheckPageParameters(pageIndex, pageSize);
            return GetProfileInfo(authenticationOption, usernameToMatch, userInactiveSinceDate, pageIndex, pageSize, out totalRecords);
        }

        public override ProfileInfoCollection FindProfilesByUserName(ProfileAuthenticationOption authenticationOption, string usernameToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            CheckPageParameters(pageIndex, pageSize);
            return GetProfileInfo(authenticationOption, usernameToMatch, null, pageIndex, pageSize, out totalRecords);
        }

        public override ProfileInfoCollection GetAllInactiveProfiles(ProfileAuthenticationOption authenticationOption, DateTime userInactiveSinceDate, int pageIndex, int pageSize, out int totalRecords)
        {
            CheckPageParameters(pageIndex, pageSize);
            return GetProfileInfo(authenticationOption, null, userInactiveSinceDate, pageIndex, pageSize, out totalRecords);
        }

        public override ProfileInfoCollection GetAllProfiles(ProfileAuthenticationOption authenticationOption, int pageIndex, int pageSize, out int totalRecords)
        {
            CheckPageParameters(pageIndex, pageSize);
            return GetProfileInfo(authenticationOption, null, null, pageIndex, pageSize, out totalRecords);
        }


        public override int GetNumberOfInactiveProfiles(ProfileAuthenticationOption authenticationOption, DateTime userInactiveSinceDate)
        {
            int inactiveProfiles = 0;

            ProfileInfoCollection profiles = GetProfileInfo(authenticationOption, null, userInactiveSinceDate, 0, 0, out inactiveProfiles);
            return inactiveProfiles;
        }



        private ProfileInfoCollection GetProfileInfo(ProfileAuthenticationOption authenticationOption, string usernameToMatch, object userInactiveSinceDate, int pageIndex, int pageSize, out int totalRecords)
        {
            SqlConnection con = new SqlConnection(_connectionString);


            // Command to retrieve the total count.
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Profiles WHERE ApplicationName = @ApplicationName ", con);
            cmd.Parameters.AddWithValue("@ApplicationName", _applicationName);


            // Command to retrieve the profile data.
            SqlCommand cmd2 = new SqlCommand("SELECT Username, LastActivityDate, LastUpdatedDate, IsAnonymous FROM Profiles WHERE ApplicationName = @ApplicationName ", con);
            cmd2.Parameters.AddWithValue("@ApplicationName", _applicationName);


            // If searching for a user name to match, add the command text and parameters.
            if (usernameToMatch != null)
            {
                cmd.CommandText += " AND Username LIKE @UserName ";
                cmd.Parameters.AddWithValue("@Username", usernameToMatch);

                cmd2.CommandText += " AND Username LIKE @UserName ";
                cmd2.Parameters.AddWithValue("@Username", usernameToMatch);
            }


            // If searching for inactive profiles, 
            // add the command text and parameters.
            if (userInactiveSinceDate != null)
            {
                cmd.CommandText += " AND LastActivityDate <= @LastActivityDate ";
                cmd.Parameters.AddWithValue("@LastActivityDate", (DateTime)userInactiveSinceDate);

                cmd2.CommandText += " AND LastActivityDate <= ? ";
                cmd2.Parameters.AddWithValue("@LastActivityDate", (DateTime)userInactiveSinceDate);
            }


            // If searching for a anonymous or authenticated profiles,    
            // add the command text and parameters.
            switch (authenticationOption)
            {
                case ProfileAuthenticationOption.Anonymous:
                    cmd.CommandText += " AND IsAnonymous = @IsAnonymous";
                    cmd.Parameters.AddWithValue("@IsAnonymous", true);
                    cmd2.CommandText += " AND IsAnonymous = @IsAnonymous";
                    cmd2.Parameters.AddWithValue("@IsAnonymous", true);
                    break;
                case ProfileAuthenticationOption.Authenticated:
                    cmd.CommandText += " AND IsAnonymous = @IsAnonymous";
                    cmd.Parameters.AddWithValue("@IsAnonymous", false);
                    cmd2.CommandText += " AND IsAnonymous = @IsAnonymous";
                    cmd2.Parameters.AddWithValue("@IsAnonymous", false);
                    break;
                default:
                    break;
            }


            // Get the data.
            SqlDataReader reader = null;
            ProfileInfoCollection profiles = new ProfileInfoCollection();

            using (con)
            {
                con.Open();
                // Get the profile count.
                totalRecords = (int)cmd.ExecuteScalar();
                // No profiles found.
                if (totalRecords <= 0) { return profiles; }
                // Count profiles only.
                if (pageSize == 0) { return profiles; }

                reader = cmd2.ExecuteReader();

                int counter = 0;
                int startIndex = pageSize * (pageIndex - 1);
                int endIndex = startIndex + pageSize - 1;

                while (reader.Read())
                {
                    if (counter >= startIndex)
                    {
                        ProfileInfo p = GetProfileInfoFromReader(reader);
                        profiles.Add(p);
                    }

                    if (counter >= endIndex)
                    {
                        cmd.Cancel();
                        break;
                    }

                    counter++;
                }

            }

            return profiles;
        }


        private ProfileInfo GetProfileInfoFromReader(SqlDataReader reader)
        {
            string username = (string)reader["UserName"];

            DateTime lastActivityDate = new DateTime();
            if (reader.GetValue(1) != DBNull.Value)
                lastActivityDate = reader.GetDateTime(1);

            DateTime lastUpdatedDate = new DateTime();
            if (reader.GetValue(2) != DBNull.Value)
                lastUpdatedDate = reader.GetDateTime(2);

            bool isAnonymous = reader.GetBoolean(3);

            // ProfileInfo.Size not currently implemented.
            ProfileInfo p = new ProfileInfo(username,
                isAnonymous, lastActivityDate, lastUpdatedDate, 0);

            return p;
        }

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

    }
}



