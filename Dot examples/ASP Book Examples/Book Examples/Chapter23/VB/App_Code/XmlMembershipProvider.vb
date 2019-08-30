Imports System
Imports System.Web.Security
Imports System.Collections
Imports System.Collections.Specialized
Imports System.Xml
Imports System.Web
Imports System.Web.Caching
Imports System.Text.RegularExpressions
Imports System.Web.Hosting
Imports System.IO
Imports System.Text
Imports System.Security.Cryptography

Namespace AspNetUnleashed

    ''' <summary>
    ''' Stores Membership information in an XML file
    ''' </summary>
    Public Class XmlMembershipProvider
        Inherits MembershipProvider

        Private _dataFile As String = "~/App_Data/Membership.xml"
        Private _applicationName As String
        Private _requiresQuestionAndAnswer As Boolean = True
        Private _enablePasswordRetrieval As Boolean = False
        Private _enablePasswordReset As Boolean = True
        Private _requiresUniqueEmail As Boolean = False
        Private _passwordFormat As MembershipPasswordFormat = MembershipPasswordFormat.Clear

        ''' <summary>
        ''' Read the configuration settings for the XmlMembershipProvider
        ''' </summary>
        Public Overrides Sub Initialize(ByVal name As String, ByVal config As NameValueCollection)
            If Not String.IsNullOrEmpty(config("applicationName")) Then
                _applicationName = config("applicationName")
            Else
                _applicationName = HostingEnvironment.ApplicationVirtualPath
            End If

            If Not String.IsNullOrEmpty(config("dataFile")) Then
                _dataFile = config("dataFile")
            End If
            If Not String.IsNullOrEmpty(config("requiresQuestionAndAnswer")) Then
                _requiresQuestionAndAnswer = Boolean.Parse(config("requiresQuestionAndAnswer"))
            End If
            If Not String.IsNullOrEmpty(config("enablePasswordRetrieval")) Then
                _enablePasswordRetrieval = Boolean.Parse(config("enablePasswordRetrieval"))
            End If
            If Not String.IsNullOrEmpty(config("enablePasswordReset")) Then
                _enablePasswordReset = Boolean.Parse(config("enablePasswordReset"))
            End If
            If Not String.IsNullOrEmpty(config("requiresUniqueEmail")) Then
                _requiresUniqueEmail = Boolean.Parse(config("requiresUniqueEmail"))
            End If
            If Not String.IsNullOrEmpty(config("passwordFormat")) Then
                _passwordFormat = CType(System.Enum.Parse(GetType(MembershipPasswordFormat), config("passwordFormat")), MembershipPasswordFormat)
            End If
            MyBase.Initialize(name, config)
        End Sub


        ''' <summary>
        ''' Retreive the XML file of users and cache it
        ''' </summary>
        Private Function GetXmlUsers() As XmlDocument
            Dim xmlUsers As XmlDocument = CType(HostingEnvironment.Cache("Users"), XmlDocument)
            If IsNothing(xmlUsers) Then
                ' Load Users from XML document
                Dim absPath As String = HostingEnvironment.MapPath(_dataFile)
                EnsureXmlFile(absPath)
                xmlUsers = New XmlDocument()
                xmlUsers.Load(absPath)

                ' Cache XML Document
                Dim fileDepend As New CacheDependency(absPath)
                HostingEnvironment.Cache.Insert("Users", xmlUsers, fileDepend)
            End If
            Return xmlUsers
        End Function

        ''' <summary>
        ''' Get a single user from the (cached) XML file
        ''' </summary>
        Private Function GetXmlUser(ByVal users As XmlDocument, ByVal username As String) As XmlElement
            Dim element As XmlElement
            For Each element In users.DocumentElement.ChildNodes
                If element.Attributes("name").Value = username Then
                    Return element
                End If
            Next
            Return Nothing
        End Function

        ''' <summary>
        ''' Save XML file back to hard drive
        ''' </summary>
        Private Sub SaveXmlUsers(ByVal users As XmlDocument)
            Dim lockThis As New Object()
            SyncLock lockThis
                users.Save(HostingEnvironment.MapPath(_dataFile))
            End SyncLock
        End Sub

        ''' <summary>
        ''' If XML file doesn't exist, create ite
        ''' </summary>
        Private Sub EnsureXmlFile(ByVal path As String)
            If Not File.Exists(path) Then
                Dim proto As XmlDocument = New XmlDocument()
                proto.LoadXml("<credentials></credentials>")
                proto.Save(path)
            End If
        End Sub

        ''' <summary>
        ''' Utility method that converts an XML user element
        ''' to a MembershipUser
        ''' </summary>
        Private Function CreateUserFromElement(ByVal element As XmlElement) As MembershipUser
            ' Required Attribute
            If String.IsNullOrEmpty(element.Attributes("name").Value) Then
                Throw New Exception("user element missing name attribute")
            End If
            Dim username As String = element.Attributes("name").Value

            ' Optional Attributes
            Dim email As String = String.Empty
            If element.HasAttribute("email") Then
                email = element.Attributes("email").Value
            End If
            Dim passwordQuestion As String = String.Empty
            If element.HasAttribute("passwordQuestion") Then
                passwordQuestion = element.Attributes("passwordQuestion").Value
            End If
            Dim comment As String = String.Empty
            If element.HasAttribute("comment") Then
                passwordQuestion = element.Attributes("comment").Value
            End If
            Dim isActive As Boolean = True
            If element.HasAttribute("isActive") Then
                isActive = Boolean.Parse(element.Attributes("isActive").Value)
            End If
            Dim isLockedOut As Boolean = False
            If element.HasAttribute("isLockedOut") Then
                isActive = Boolean.Parse(element.Attributes("isLockedOut").Value)
            End If

            Dim user As New MembershipUser( _
                Me.Name, _
                username, _
                username, _
                email, _
                passwordQuestion, _
                comment, _
                isActive, _
                isLockedOut, _
                DateTime.MinValue, _
                DateTime.MinValue, _
                DateTime.MinValue, _
                DateTime.MinValue, _
                DateTime.MinValue)
            Return user
        End Function

        ''' <summary>
        ''' The ApplicationName isn't really used since
        ''' the XML file is stored in a particular application.
        ''' </summary>
        Public Overrides Property ApplicationName() As String
            Get
                Return _applicationName
            End Get
            Set(ByVal Value As String)
                _applicationName = Value
            End Set
        End Property

        ''' <summary>
        ''' Validate user name and password
        ''' against XML file
        ''' </summary>
        Public Overrides Function ValidateUser(ByVal username As String, ByVal password As String) As Boolean
            Dim xmlUsers As XmlDocument = GetXmlUsers()
            For Each element As XmlElement In xmlUsers.DocumentElement.ChildNodes
                If (element.Attributes("name").Value = username And element.Attributes("password").Value = CreatePassword(password)) Then
                    Return True
                End If
            Next
            Return False
        End Function

        ''' <summary>
        ''' Get the password for a particular user
        ''' </summary>
        Public Overrides Function GetPassword(ByVal username As String, ByVal answer As String) As String
            If Not EnablePasswordRetrieval Then
                Throw New NotSupportedException("Retrieving passwords is not supported")
            End If
            If _passwordFormat = MembershipPasswordFormat.Hashed Then
                Throw New System.Configuration.ConfigurationException("Can't retrieve hashed password")
            End If
            Dim xmlUsers As XmlDocument = GetXmlUsers()
            For Each element As XmlElement In xmlUsers.DocumentElement.ChildNodes
                If (element.Attributes("name").Value = username) Then
                    Return element.Attributes("password").Value
                End If
            Next
            Return Nothing
        End Function

        ''' <summary>
        ''' Add a new user element to the XML file
        ''' </summary>
        Public Overrides Function CreateUser(ByVal username As String, ByVal password As String, ByVal email As String, ByVal passwordQuestion As String, ByVal passwordAnswer As String, ByVal isApproved As Boolean, ByVal providerUserKey As Object, ByRef status As MembershipCreateStatus) As MembershipUser
            Dim xmlUsers As XmlDocument = GetXmlUsers()

            ' Check for duplicate username
            If Not IsNothing(GetUser(username, True)) Then
                status = MembershipCreateStatus.DuplicateUserName
                Return Nothing
            End If

            ' Check for duplicate email
            If _requiresUniqueEmail Then
                If Not IsNothing(GetUserNameByEmail(email)) Then
                    status = MembershipCreateStatus.DuplicateEmail
                    Return Nothing
                End If
            End If

            Dim NewUser As XmlElement = xmlUsers.CreateElement("user")
            NewUser.SetAttribute("name", username)
            NewUser.SetAttribute("password", CreatePassword(password))
            NewUser.SetAttribute("email", email)

            If Not String.IsNullOrEmpty(passwordQuestion) Then
                NewUser.SetAttribute("passwordQuestion", passwordQuestion)
            End If
            If Not String.IsNullOrEmpty(passwordAnswer) Then
                NewUser.SetAttribute("passwordAnswer", passwordAnswer)
            End If
            If Not isApproved Then
                NewUser.SetAttribute("isApprovided", "false")
            End If

            xmlUsers.DocumentElement.AppendChild(NewUser)
            SaveXmlUsers(xmlUsers)
            status = MembershipCreateStatus.Success
            Return CreateUserFromElement(NewUser)
        End Function


        ''' <summary>
        ''' Update user element in XML file
        ''' </summary>
        ''' <param name="user"></param>
        Public Overrides Sub UpdateUser(ByVal user As MembershipUser)
            Dim xmlUsers As XmlDocument = GetXmlUsers()
            Dim xmlUser As XmlElement = GetXmlUser(xmlUsers, user.UserName)

            If Not IsNothing(xmlUser) Then
                xmlUser.SetAttribute("name", user.UserName)
                xmlUser.SetAttribute("email", user.Email)
                xmlUser.SetAttribute("isApproved", user.IsApproved.ToString())

                If Not String.IsNullOrEmpty(user.Comment) Then
                    xmlUser.SetAttribute("comment", user.Comment)
                End If
                If Not String.IsNullOrEmpty(user.PasswordQuestion) Then
                    xmlUser.SetAttribute("passwordQuestion", user.PasswordQuestion)
                End If
                SaveXmlUsers(xmlUsers)
            End If
        End Sub

        ''' <summary>
        ''' Hash, Encrypt, or leave the password alone depending
        ''' on the passwordFormat setting
        ''' </summary>
        Private Function CreatePassword(ByVal password As String) As String
            If _passwordFormat = MembershipPasswordFormat.Hashed Then
                password = FormsAuthentication.HashPasswordForStoringInConfigFile(password, "SHA1")
            End If
            Return password
        End Function

        ''' <summary>
        ''' Retrieve all user elements from XML file ignoring
        ''' page index and page size
        ''' </summary>
        Public Overrides Function GetAllUsers(ByVal pageIndex As Integer, ByVal pageSize As Integer, ByRef totalRecords As Integer) As MembershipUserCollection
            Dim xmlUsers As XmlDocument = GetXmlUsers()
            Dim colUsers As New MembershipUserCollection()
            For Each element As XmlElement In xmlUsers.DocumentElement.ChildNodes
                Dim user As MembershipUser = CreateUserFromElement(element)
                colUsers.Add(user)
            Next
            totalRecords = colUsers.Count
            Return colUsers
        End Function

        ''' <summary>
        ''' Return all users who have the specified email address
        ''' </summary>
        Public Overrides Function FindUsersByEmail(ByVal emailToMatch As String, ByVal pageIndex As Integer, ByVal pageSize As Integer, ByRef totalRecords As Integer) As MembershipUserCollection
            Dim xmlUsers As XmlDocument = GetXmlUsers()
            Dim colUsers As MembershipUserCollection = New MembershipUserCollection()
            Dim element As XmlElement
            For Each element In xmlUsers.DocumentElement.ChildNodes
                If element.HasAttribute("email") Then
                    If element.Attributes("email").Value = emailToMatch Then
                        Dim user As MembershipUser = CreateUserFromElement(element)
                        colUsers.Add(user)
                    End If
                End If
            Next
            totalRecords = colUsers.Count
            Return colUsers
        End Function

        ''' <summary>
        ''' Return all users who have the specified username
        ''' </summary>
        Public Overrides Function FindUsersByName(ByVal usernameToMatch As String, ByVal pageIndex As Integer, ByVal pageSize As Integer, ByRef totalRecords As Integer) As MembershipUserCollection
            Dim xmlUsers As XmlDocument = GetXmlUsers()
            Dim colUsers As New MembershipUserCollection()
            For Each element As XmlElement In xmlUsers.DocumentElement.ChildNodes
                If element.Attributes("name").Value = usernameToMatch Then
                    Dim user As MembershipUser = CreateUserFromElement(element)
                    colUsers.Add(user)
                End If
            Next
            totalRecords = colUsers.Count
            Return colUsers
        End Function

        ''' <summary>
        ''' Change the user password
        ''' </summary>
        Public Overrides Function ChangePassword(ByVal username As String, ByVal oldPassword As String, ByVal NewPassword As String) As Boolean
            Dim users As XmlDocument = GetXmlUsers()
            Dim user As XmlElement = GetXmlUser(users, username)
            If IsNothing(user) Then
                Return False
            End If
            If user.Attributes("password").Value <> CreatePassword(oldPassword) Then
                Return False
            End If
            user.SetAttribute("password", CreatePassword(NewPassword))
            SaveXmlUsers(users)
            Return True
        End Function

        ''' <summary>
        ''' Change the user password question and answer
        ''' </summary>
        Public Overrides Function ChangePasswordQuestionAndAnswer(ByVal username As String, ByVal password As String, ByVal NewPasswordQuestion As String, ByVal NewPasswordAnswer As String) As Boolean
            Dim users As XmlDocument = GetXmlUsers()
            Dim user As XmlElement = GetXmlUser(users, username)
            If IsNothing(user) Then
                Return False
            End If
            If user.Attributes("password").Value <> CreatePassword(password) Then
                Return False
            End If
            user.SetAttribute("passwordQuestion", NewPasswordQuestion)
            user.SetAttribute("passwordAnswer", NewPasswordAnswer)
            SaveXmlUsers(users)
            Return True
        End Function

        ''' <summary>
        ''' Reset password to a randomly generated password
        ''' </summary>
        Public Overrides Function ResetPassword(ByVal username As String, ByVal answer As String) As String
            If (Not _requiresQuestionAndAnswer) Then
                Throw New NotSupportedException("Reset password not supported when requiresQuestionAndAnswer is False.")
            End If
            Dim users As XmlDocument = GetXmlUsers()
            Dim user As XmlElement = GetXmlUser(users, username)
            If IsNothing(user) Then
                Throw New Exception("User not found")
            End If
            If user.Attributes("passwordAnswer").Value <> answer Then
                Throw New Exception("Invalid answer")
            End If
            Dim NewPassword As String = Membership.GeneratePassword(15, 1)
            user.SetAttribute("password", CreatePassword(NewPassword))
            SaveXmlUsers(users)
            Return NewPassword
        End Function


        ''' <summary>
        ''' Get a single user from the cached XML file
        ''' </summary>
        Public Overrides Function GetUser(ByVal username As String, ByVal userIsOnline As Boolean) As MembershipUser
            Dim users As XmlDocument = GetXmlUsers()
            For Each element As XmlElement In users.DocumentElement.ChildNodes
                If element.Attributes("name").Value = username Then
                    Return CreateUserFromElement(element)
                End If
            Next
            Return Nothing
        End Function


        ''' <summary>
        ''' Get a single user by provider key.
        ''' This provider just calls the GetUser() method
        ''' and pretends that the user name is a key
        ''' </summary>
        Public Overrides Function GetUser(ByVal providerUserKey As Object, ByVal userIsOnline As Boolean) As MembershipUser
            Return GetUser(providerUserKey, True)
        End Function

        ''' <summary>
        ''' Return the user name that matches an email address
        ''' </summary>
        Public Overrides Function GetUserNameByEmail(ByVal email As String) As String
            Dim users As XmlDocument = GetXmlUsers()

            For Each element As XmlElement In users.DocumentElement.ChildNodes
                If element.Attributes("email").Value = email Then
                    Return element.Attributes("name").Value
                End If
            Next
            Return Nothing
        End Function


        Public Overrides Function DeleteUser(ByVal username As String, ByVal deleteAllRelatedData As Boolean) As Boolean
            Dim users As XmlDocument = GetXmlUsers()
            For Each element As XmlElement In users.DocumentElement.ChildNodes
                If element.Attributes("name").Value = username Then
                    element.ParentNode.RemoveChild(element)
                    SaveXmlUsers(users)
                    Return True
                End If
            Next
            Return False
        End Function

        ''' <summary>
        ''' This setting is read from the config file
        ''' </summary>
        Public Overrides ReadOnly Property RequiresQuestionAndAnswer() As Boolean
            Get
                Return _requiresQuestionAndAnswer
            End Get
        End Property

        ''' <summary>
        ''' This setting is read from the config file
        ''' </summary>
        Public Overrides ReadOnly Property EnablePasswordReset() As Boolean
            Get
                Return _enablePasswordReset
            End Get
        End Property

        ''' <summary>
        ''' This setting is read from the config file
        ''' </summary>
        Public Overrides ReadOnly Property EnablePasswordRetrieval() As Boolean
            Get
                If _passwordFormat = MembershipPasswordFormat.Hashed And _enablePasswordRetrieval Then
                    Throw New Exception("Retrieving passwords not supported when hashed")
                End If
                Return _enablePasswordRetrieval
            End Get
        End Property

        ''' <summary>
        ''' This setting is read from the config file
        ''' </summary>
        Public Overrides ReadOnly Property PasswordFormat() As MembershipPasswordFormat
            Get
                Return _passwordFormat
            End Get
        End Property

        ''' <summary>
        ''' Don't require a unique email
        ''' </summary>
        Public Overrides ReadOnly Property RequiresUniqueEmail() As Boolean
            Get
                Return False
            End Get
        End Property
        Public Overrides ReadOnly Property MinRequiredNonAlphanumericCharacters() As Integer
            Get
                Return 0
            End Get
        End Property

        Public Overrides ReadOnly Property MinRequiredPasswordLength() As Integer
            Get
                Return 1
            End Get
        End Property


        ''' 
        ''' The following methods are not implemented to prevent
        ''' excessive writing to the XML file
        ''' 

        Public Overrides Function GetNumberOfUsersOnline() As Integer
            Throw New Exception("The method or operation is not implemented.")
        End Function

        Public Overrides ReadOnly Property MaxInvalidPasswordAttempts() As Integer
            Get
                Throw New Exception("The method or operation is not implemented.")
            End Get
        End Property


        Public Overrides ReadOnly Property PasswordAttemptWindow() As Integer
            Get
                Throw New Exception("The method or operation is not implemented.")
            End Get
        End Property

        Public Overrides ReadOnly Property PasswordStrengthRegularExpression() As String
            Get
                Throw New Exception("The method or operation is not implemented.")
            End Get
        End Property

        Public Overrides Function UnlockUser(ByVal userName As String) As Boolean
            Throw New Exception("The method or operation is not implemented.")
        End Function

    End Class
End Namespace

