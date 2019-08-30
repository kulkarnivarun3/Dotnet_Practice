Imports System
Imports System.Collections
Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Web.Profile
Imports System.Collections.Specialized
Imports System.Web.Configuration
Imports System.Web.Hosting


' This provider assumes the existence of the following Profiles table:
'  
' CREATE TABLE Profiles
' (
'   UniqueID IDENTITY NOT NULL PRIMARY KEY,
'   UserName NVarchar(255) NOT NULL,
'   ApplicationName NVarchar(255) NOT NULL,
'   IsAnonymous BIT, 
'   LastActivityDate DateTime,
'   LastUpdatedDate DateTime,
' )
'  
' Profile data is stored in a table named ProfileData. This table must
' include a column named ProfileID. The remaining columns correspond
' to the profile properties that you define in the Web.Config file.
'  
'  
' CREATE TABLE ProfileData
' {
'   ProfileID INT,
'   ProfileProp1,
'   ProfileProp2,
'   ProfileProp3, ...
' }  
'  
'  




Namespace AspNetUnleashed

    ''' <summary>
    ''' Enables you to store profile properties in different 
    ''' database table columns
    ''' </summary>
    Public Class BetterProfileProvider
        Inherits ProfileProvider

        Private _applicationName As String
        Private _connectionString As String
        Private _profileTableName As String = "ProfileData"

        ''' <summary>
        ''' We need configuration stuff like the connection string and
        ''' name of the table in which to store profile data
        ''' </summary>
        Public Overrides Sub Initialize(ByVal name As String, ByVal config As NameValueCollection)
            ' Get the Application Name
            _applicationName = HostingEnvironment.ApplicationVirtualPath
            If Not String.IsNullOrEmpty(config("applicationName")) Then
                _applicationName = CType(config("applicationName"), String)
            End If

            ' Get the connection string
            If String.IsNullOrEmpty(config("connectionStringName")) Then
                Throw New ConfigurationException("You must specify a connectionStringName")
            End If
            Dim connectionStringName As String = CType(config("connectionStringName"), String)
            Dim connection As ConnectionStringSettings = WebConfigurationManager.ConnectionStrings(connectionStringName)
            If IsNothing(connection) Then
                Throw New ConfigurationException("Could not find connection String " + connectionStringName)
            End If
            _connectionString = connection.ConnectionString

            ' Get the Profile Table Name
            If Not String.IsNullOrEmpty(config("profileTableName")) Then
                _profileTableName = CType(config("profileTableName"), String)
            End If

            MyBase.Initialize(name, config)
        End Sub


        Public Overrides Function GetPropertyValues(ByVal context As SettingsContext, ByVal collection As SettingsPropertyCollection) As SettingsPropertyValueCollection
            Dim results As SettingsPropertyValueCollection = New SettingsPropertyValueCollection()
            For Each prop As SettingsProperty In collection
                results.Add(New SettingsPropertyValue(prop))
            Next

            ' Get Settings
            Dim userName As String = CType(context("UserName"), String)
            Dim isAuthenticated As Boolean = CType(context("IsAuthenticated"), Boolean)

            ' Build Command Text
            Dim commandText As String = String.Format("SELECT profileData.* FROM Profiles INNER JOIN {0} AS profileData ON UniqueID=ProfileID WHERE Username=@Username AND ApplicationName=@ApplicationName AND IsAnonymous=@IsAnonymous", _profileTableName)

            ' Execute command
            Dim dad As New SqlDataAdapter(commandText, _connectionString)
            dad.SelectCommand.Parameters.AddWithValue("@Username", userName)
            dad.SelectCommand.Parameters.AddWithValue("@ApplicationName", _applicationName)
            dad.SelectCommand.Parameters.AddWithValue("@IsAnonymous", Not isAuthenticated)
            Using dad
                Dim tblResults As DataTable = New DataTable()
                dad.Fill(tblResults)
                If tblResults.Rows.Count > 0 Then
                    For Each prop As SettingsPropertyValue In results
                        If tblResults.Columns.Contains(prop.Name) Then
                            prop.PropertyValue = tblResults.Rows(0)(prop.Name)
                        End If
                    Next
                End If
            End Using
            UpdateActivityDates(userName, isAuthenticated, True)
            Return results
        End Function

        Public Overrides Sub SetPropertyValues(ByVal context As SettingsContext, ByVal collection As SettingsPropertyValueCollection)
            ' Get Settings
            Dim userName As String = CType(context("UserName"), String)
            Dim isAuthenticated As Boolean = CType(context("IsAuthenticated"), Boolean)

            ' Get Profile ID
            Dim profileID As Integer = GetProfileID(userName, isAuthenticated, False)
            If (profileID = 0) Then
                profileID = CreateProfile(userName, isAuthenticated)
            End If

            ' Dynamically build command text
            Dim colColumns As New List(Of String)()
            Dim colValues As New List(Of String)()
            For Each pv As SettingsPropertyValue In collection
                colColumns.Add(pv.Property.Name)
                colValues.Add("@" & pv.Property.Name)
            Next
            Dim arrColumns() As String = colColumns.ToArray()
            Dim columnList As String = String.Join(",", arrColumns)
            Dim arrValues() As String = colValues.ToArray()
            Dim ValueList As String = String.Join(",", arrValues)
            Dim commandText As String = String.Format("INSERT {0} (ProfileID,{1}) VALUES (@ProfileID,{2})", _profileTableName, columnList, ValueList)

            ' Create command
            Dim con As New SqlConnection(_connectionString)
            Dim cmd As New SqlCommand(commandText, con)

            ' Build parameters
            cmd.Parameters.AddWithValue("@ProfileID", profileID)
            For Each col As String In arrColumns
                cmd.Parameters.AddWithValue("@" & col, collection(col).PropertyValue)
            Next

            ' Create delete command
            Dim deleteCommandText As String = String.Format("DELETE {0} WHERE ProfileID=@ProfileID", _profileTableName)
            Dim cmdDelete As New SqlCommand(deleteCommandText, con)
            cmdDelete.Parameters.AddWithValue("@ProfileID", profileID)

            ' Execute the commands (transactionally)
            Dim tran As SqlTransaction = Nothing
            Try
                con.Open()
                tran = con.BeginTransaction()
                cmdDelete.Transaction = tran
                cmd.Transaction = tran
                cmdDelete.ExecuteNonQuery()
                cmd.ExecuteNonQuery()
                tran.Commit()
            Catch
                tran.Rollback()
            Finally
                con.Close()
            End Try
            UpdateActivityDates(userName, isAuthenticated, True)
        End Sub


        Private Function GetProfileID(ByVal userName As String, ByVal isAuthenticated As Boolean, ByVal ignoreAuthentication As Boolean) As Integer
            Dim result As Integer = 0
            Dim con As New SqlConnection(_connectionString)
            Dim cmd As New SqlCommand("SELECT UniqueID FROM Profiles WHERE UserName=@UserName AND ApplicationName=@ApplicationName", con)
            cmd.Parameters.AddWithValue("@UserName", userName)
            cmd.Parameters.AddWithValue("@ApplicationName", _applicationName)

            If Not ignoreAuthentication Then
                cmd.CommandText += " AND IsAnonymous=@IsAnonymous"
                cmd.Parameters.AddWithValue("@IsAnonymous", Not isAuthenticated)
            End If

            Using con
                con.Open()
                Dim dbResult As Object = cmd.ExecuteScalar()
                If Not IsNothing(dbResult) Then
                    result = CType(dbResult, Integer)
                End If
            End Using
            Return result
        End Function


        Private Function CreateProfile(ByVal userName As String, ByVal isAuthenticated As Boolean) As Integer
            Dim result As Integer = 0

            ' Check for valid user name.
            If (userName = Nothing) Then
                Throw New ArgumentNullException("User name cannot be Nothing.")
            End If
            If (userName.Length > 255) Then
                Throw New ArgumentException("User name exceeds 255 characters.")
            End If
            If (userName.IndexOf(",") > 0) Then
                Throw New ArgumentException("User name cannot contain a comma (,).")
            End If

            ' Create command to add profile
            Dim con As New SqlConnection(_connectionString)
            Dim cmd As New SqlCommand("INSERT Profiles (UserName,ApplicationName,IsAnonymous,LastActivityDate,LastUpdatedDate) VALUES (@UserName,@ApplicationName,@IsAnonymous,@LastActivityDate,@LastUpdatedDate)", con)
            cmd.Parameters.AddWithValue("@UserName", userName)
            cmd.Parameters.AddWithValue("@ApplicationName", _applicationName)
            cmd.Parameters.AddWithValue("@IsAnonymous", Not isAuthenticated)
            cmd.Parameters.AddWithValue("@LastActivityDate", DateTime.Now)
            cmd.Parameters.AddWithValue("@LastUpdatedDate", DateTime.Now)

            ' Create command to get profile identity
            Dim cmd2 As SqlCommand = New SqlCommand("SELECT @@IDENTITY", con)

            Using con
                con.Open()
                cmd.ExecuteNonQuery()
                result = CType(cmd2.ExecuteScalar(), Integer)
            End Using
            Return result
        End Function



        Private Sub UpdateActivityDates(ByVal username As String, ByVal isAuthenticated As Boolean, ByVal activityOnly As Boolean)
            Dim con As New SqlConnection(_connectionString)
            Dim cmd As SqlCommand = con.CreateCommand()

            If activityOnly Then
                cmd.CommandText = "UPDATE Profiles SET LastActivityDate=GetDate() WHERE UserName=@UserName AND ApplicationName=@ApplicationName AND IsAnonymous=@IsAnonymous"
            Else
                cmd.CommandText = "UPDATE Profiles SET LastActivityDate=GetDate(),LastUpdatedDate=GetDate() WHERE UserName=@UserName AND ApplicationName=@ApplicationName AND IsAnonymous=@IsAnonymous"
            End If

            ' Add Parameters
            cmd.Parameters.AddWithValue("@UserName", username)
            cmd.Parameters.AddWithValue("@ApplicationName", _applicationName)
            cmd.Parameters.AddWithValue("@IsAnonymous", Not isAuthenticated)
            Using con
                con.Open()
                cmd.ExecuteNonQuery()
            End Using
        End Sub

        Public Overrides Function DeleteInactiveProfiles(ByVal authenticationOption As ProfileAuthenticationOption, ByVal userInactiveSinceDate As DateTime) As Integer
            Dim con As New SqlConnection(_connectionString)
            Dim cmd As New SqlCommand("SELECT Username FROM Profiles WHERE ApplicationName = @ApplicationName AND LastActivityDate <= @LastActivityDate", con)
            cmd.Parameters.AddWithValue("@ApplicationName", ApplicationName)
            cmd.Parameters.AddWithValue("@LastActivityDate", userInactiveSinceDate)

            Select Case authenticationOption
                Case ProfileAuthenticationOption.Anonymous
                    cmd.CommandText += " AND IsAnonymous = @IsAnonymous"
                    cmd.Parameters.AddWithValue("@IsAnonymous", True)
                Case ProfileAuthenticationOption.Authenticated
                    cmd.CommandText += " AND IsAnonymous = @IsAnonymous"
                    cmd.Parameters.AddWithValue("@IsAnonymous", False)
            End Select

            Dim reader As SqlDataReader = Nothing
            Dim usernames As String = String.Empty

            Using con
                con.Open()
                reader = cmd.ExecuteReader()
                While reader.Read()
                    usernames &= String.Format("{0},", reader("UserName"))
                End While
            End Using

            ' Remove trailing comma.
            If usernames.Length > 0 Then
                usernames = usernames.Substring(0, usernames.Length - 1)
            End If

            ' Delete profiles.
            Return DeleteProfiles(usernames.Split(","c))
        End Function

        Public Overrides Function DeleteProfiles(ByVal usernames() As String) As Integer
            Dim deleteCount As Integer = 0

            Dim con As New SqlConnection(_connectionString)
            Dim tran As SqlTransaction = Nothing
            Try
                con.Open()
                tran = con.BeginTransaction()
                For Each userName As String In usernames
                    If DeleteProfile(userName, con, tran) Then
                        deleteCount = deleteCount + 1
                    End If
                Next
                tran.Commit()
            Catch
                tran.Rollback()
            Finally
                con.Close()
            End Try

            Return deleteCount
        End Function

        Public Overrides Function DeleteProfiles(ByVal profiles As ProfileInfoCollection) As Integer
            Dim colProfiles As New List(Of String)()
            For Each p As ProfileInfo In profiles
                colProfiles.Add(p.UserName)
            Next
            Return DeleteProfiles(colProfiles.ToArray())
        End Function




        Private Function DeleteProfile(ByVal userName As String, ByVal con As SqlConnection, ByVal tran As SqlTransaction) As Boolean
            Dim profileID As Integer = GetProfileID(userName, False, True)

            ' Create commands
            Dim cmd As New SqlCommand("DELETE Profiles WHERE UniqueID=@ProfileID", con)
            Dim deleteCommandText As String = String.Format("DELETE {0} WHERE ProfileID=@ProfileID", _profileTableName)
            Dim cmd2 As New SqlCommand(deleteCommandText, con)

            ' Enroll in transaction
            cmd.Transaction = tran
            cmd2.Transaction = tran

            ' Add Parameters
            cmd.Parameters.AddWithValue("@ProfileID", profileID)
            cmd2.Parameters.AddWithValue("@ProfileID", profileID)

            Dim numDeleted As Integer = 0

            numDeleted += cmd.ExecuteNonQuery()
            numDeleted += cmd2.ExecuteNonQuery()

            If numDeleted > 0 Then
                Return True
            Else
                Return False
            End If
        End Function

        Private Sub CheckPageParameters(ByVal pageIndex As Integer, ByVal pageSize As Integer)
            If pageIndex < 0 Then
                Throw New ArgumentException("Page index must 0 or greater.")
            End If
            If (pageSize < 1) Then
                Throw New ArgumentException("Page size must be greater than 0.")
            End If
        End Sub

        Public Overrides Function FindInactiveProfilesByUserName(ByVal authenticationOption As ProfileAuthenticationOption, ByVal usernameToMatch As String, ByVal userInactiveSinceDate As DateTime, ByVal pageIndex As Integer, ByVal pageSize As Integer, ByRef totalRecords As Integer) As ProfileInfoCollection
            CheckPageParameters(pageIndex, pageSize)
            Return GetProfileInfo(authenticationOption, usernameToMatch, userInactiveSinceDate, pageIndex, pageSize, totalRecords)
        End Function

        Public Overrides Function FindProfilesByUserName(ByVal authenticationOption As ProfileAuthenticationOption, ByVal usernameToMatch As String, ByVal pageIndex As Integer, ByVal pageSize As Integer, ByRef totalRecords As Integer) As ProfileInfoCollection
            CheckPageParameters(pageIndex, pageSize)
            Return GetProfileInfo(authenticationOption, usernameToMatch, Nothing, pageIndex, pageSize, totalRecords)
        End Function

        Public Overrides Function GetAllInactiveProfiles(ByVal authenticationOption As ProfileAuthenticationOption, ByVal userInactiveSinceDate As DateTime, ByVal pageIndex As Integer, ByVal pageSize As Integer, ByRef totalRecords As Integer) As ProfileInfoCollection
            CheckPageParameters(pageIndex, pageSize)
            Return GetProfileInfo(authenticationOption, Nothing, userInactiveSinceDate, pageIndex, pageSize, totalRecords)
        End Function

        Public Overrides Function GetAllProfiles(ByVal authenticationOption As ProfileAuthenticationOption, ByVal pageIndex As Integer, ByVal pageSize As Integer, ByRef totalRecords As Integer) As ProfileInfoCollection
            CheckPageParameters(pageIndex, pageSize)
            Return GetProfileInfo(authenticationOption, Nothing, Nothing, pageIndex, pageSize, totalRecords)
        End Function

        Public Overrides Function GetNumberOfInactiveProfiles(ByVal authenticationOption As ProfileAuthenticationOption, ByVal userInactiveSinceDate As DateTime) As Integer
            Dim inactiveProfiles As Integer = 0

            Dim profiles As ProfileInfoCollection = GetProfileInfo(authenticationOption, Nothing, userInactiveSinceDate, 0, 0, inactiveProfiles)
            Return inactiveProfiles
        End Function

        Private Function GetProfileInfo(ByVal authenticationOption As ProfileAuthenticationOption, ByVal usernameToMatch As String, ByVal userInactiveSinceDate As Object, ByVal pageIndex As Integer, ByVal pageSize As Integer, ByVal totalRecords As Integer) As ProfileInfoCollection
            Dim con As New SqlConnection(_connectionString)

            ' Command to retrieve the total count.
            Dim cmd As New SqlCommand("SELECT COUNT(*) FROM Profiles WHERE ApplicationName = @ApplicationName ", con)
            cmd.Parameters.AddWithValue("@ApplicationName", _applicationName)

            ' Command to retrieve the profile data.
            Dim cmd2 As New SqlCommand("SELECT Username, LastActivityDate, LastUpdatedDate, IsAnonymous FROM Profiles WHERE ApplicationName = @ApplicationName ", con)
            cmd2.Parameters.AddWithValue("@ApplicationName", _applicationName)

            ' If searching for a user name to match, add the command text and parameters.
            If IsNothing(usernameToMatch) Then
                cmd.CommandText &= " AND Username LIKE @UserName "
                cmd.Parameters.AddWithValue("@Username", usernameToMatch)

                cmd2.CommandText &= " AND Username LIKE @UserName "
                cmd2.Parameters.AddWithValue("@Username", usernameToMatch)
            End If


            ' If searching for inactive profiles, 
            ' add the command text and parameters.
            If IsNothing(userInactiveSinceDate) Then
                cmd.CommandText &= " AND LastActivityDate <= @LastActivityDate "
                cmd.Parameters.AddWithValue("@LastActivityDate", CType(userInactiveSinceDate, DateTime))

                cmd2.CommandText &= " AND LastActivityDate <= ? "
                cmd2.Parameters.AddWithValue("@LastActivityDate", CType(userInactiveSinceDate, DateTime))
            End If


            ' If searching for a anonymous or authenticated profiles,    
            ' add the command text and parameters.
            Select Case authenticationOption
                Case ProfileAuthenticationOption.Anonymous
                    cmd.CommandText &= " AND IsAnonymous = @IsAnonymous"
                    cmd.Parameters.AddWithValue("@IsAnonymous", True)
                    cmd2.CommandText &= " AND IsAnonymous = @IsAnonymous"
                    cmd2.Parameters.AddWithValue("@IsAnonymous", True)
                Case ProfileAuthenticationOption.Authenticated
                    cmd.CommandText &= " AND IsAnonymous = @IsAnonymous"
                    cmd.Parameters.AddWithValue("@IsAnonymous", False)
                    cmd2.CommandText &= " AND IsAnonymous = @IsAnonymous"
                    cmd2.Parameters.AddWithValue("@IsAnonymous", False)
            End Select

            ' Get the data.
            Dim reader As SqlDataReader = Nothing
            Dim profiles As New ProfileInfoCollection()

            Using con
                con.Open()
                ' Get the profile count.
                totalRecords = CType(cmd.ExecuteScalar(), Integer)

                ' No profiles found.
                If totalRecords <= 0 Then
                    Return profiles
                End If

                ' Count profiles only.
                If pageSize = 0 Then
                    Return profiles
                End If

                reader = cmd2.ExecuteReader()

                Dim counter As Integer = 0
                Dim startIndex As Integer = pageSize * (pageIndex - 1)
                Dim endIndex As Integer = startIndex + pageSize - 1

                While reader.Read()
                    If (counter >= startIndex) Then
                        Dim p As ProfileInfo = GetProfileInfoFromReader(reader)
                        profiles.Add(p)
                    End If

                    If (counter >= endIndex) Then
                        cmd.Cancel()
                        Exit While
                    End If

                    counter = counter + 1
                End While

            End Using

            Return profiles
        End Function


        Private Function GetProfileInfoFromReader(ByVal reader As SqlDataReader) As ProfileInfo
            Dim username As String = CType(reader("UserName"), String)

            Dim lastActivityDate As New DateTime()
            If Not IsDBNull(reader.GetValue(1)) Then
                lastActivityDate = reader.GetDateTime(1)
            End If

            Dim lastUpdatedDate As New DateTime()
            If Not IsDBNull(reader.GetValue(2)) Then
                lastUpdatedDate = reader.GetDateTime(2)
            End If

            Dim isAnonymous As Boolean = reader.GetBoolean(3)

            ' ProfileInfo.Size not currently implemented.
            Dim p As New ProfileInfo(username, isAnonymous, lastActivityDate, lastUpdatedDate, 0)
            Return p
        End Function

        Public Overrides Property ApplicationName() As String
            Get
                Return _applicationName
            End Get
            Set(ByVal Value As String)
                _applicationName = Value
            End Set
        End Property

    End Class
End Namespace

