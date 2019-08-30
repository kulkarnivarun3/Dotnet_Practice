Imports System
Imports System.Web
Imports System.Web.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Imports System.Collections.Generic

Namespace AspNetUnleashed

    Public Class VirtualFiles

        Shared ReadOnly _connectionString As String

        ''' <summary>
        ''' Get the connection string from Web.Config
        ''' </summary>
        Shared Sub New()
            _connectionString = WebConfigurationManager.ConnectionStrings("VirtualFiles").ConnectionString
        End Sub


        ''' <summary>
        ''' Check whether file exists in database
        ''' </summary>
        Public Shared Function FileExists(ByVal virtualPath As String) As Boolean
            ' Relativize path
            virtualPath = VirtualPathUtility.ToAppRelative(virtualPath)

            ' Break virtual path
            Dim fileName As String = VirtualPathUtility.GetFileName(virtualPath)
            Dim path As String = VirtualPathUtility.GetDirectory(virtualPath)

            ' Initialize command
            Dim con As New SqlConnection(_connectionString)
            Dim commandText As String = "SELECT Name FROM VirtualFiles WHERE Path=@Path AND Name=@Name"
            Dim cmd As New SqlCommand(commandText, con)

            ' Create parameter
            cmd.Parameters.AddWithValue("@Path", path)
            cmd.Parameters.AddWithValue("@Name", fileName)

            ' Execute command
            Dim result As Boolean
            Using con
                con.Open()
                Dim reader As SqlDataReader = cmd.ExecuteReader()
                result = reader.HasRows
            End Using
            Return result
        End Function

        ''' <summary>
        ''' Add new file to database
        ''' </summary>
        Public Shared Sub FileInsert(ByVal virtualPath As String, ByVal name As String, ByVal content As String)
            ' Relativize path
            virtualPath = VirtualPathUtility.ToAppRelative(virtualPath)

            ' Initialize command
            Dim con As New SqlConnection(_connectionString)
            Dim commandText As String = "INSERT VirtualFiles (Path,Name,Content) VALUES (@Path,@Name,@Content)"
            Dim cmd As New SqlCommand(commandText, con)

            ' Create parameters
            cmd.Parameters.AddWithValue("@Path", virtualPath)
            cmd.Parameters.AddWithValue("@Name", name)
            cmd.Parameters.AddWithValue("@Content", content)

            ' Execute command
            Using con
                con.Open()
                cmd.ExecuteNonQuery()
            End Using
        End Sub

        ''' <summary>
        ''' Get contents of file
        ''' </summary>
        Public Shared Function FileContentSelect(ByVal virtualPath As String) As String
            ' Relativize path
            virtualPath = VirtualPathUtility.ToAppRelative(virtualPath)

            ' Break virtualPath
            Dim path As String = VirtualPathUtility.GetDirectory(virtualPath)
            Dim fileName As String = VirtualPathUtility.GetFileName(virtualPath)

            ' Initialize command
            Dim con As New SqlConnection(_connectionString)
            Dim commandText As String = "SELECT Content FROM VirtualFiles WHERE Path=@Path AND Name=@Name"
            Dim cmd As New SqlCommand(commandText, con)

            ' Create parameter
            cmd.Parameters.AddWithValue("@Path", path)
            cmd.Parameters.AddWithValue("@Name", fileName)

            ' Execute command
            Dim content As String
            Using con
                con.Open()
                content = CType(cmd.ExecuteScalar(), String)
            End Using
            Return content
        End Function



        ''' <summary>
        ''' Update File ccntent
        ''' </summary>
        Public Shared Sub FileContentUpdate(ByVal virtualPath As String, ByVal content As String)
            ' Relativize path
            virtualPath = VirtualPathUtility.ToAppRelative(virtualPath)

            ' Break virtualPath
            Dim path As String = VirtualPathUtility.GetDirectory(virtualPath)
            Dim fileName As String = VirtualPathUtility.GetFileName(virtualPath)

            ' Initialize command
            Dim con As New SqlConnection(_connectionString)
            Dim commandText As String = "UPDATE VirtualFiles SET Content=@Content WHERE Path=@Path AND Name=@Name"
            Dim cmd As New SqlCommand(commandText, con)

            ' Create parameter
            cmd.Parameters.AddWithValue("@Path", path)
            cmd.Parameters.AddWithValue("@Name", fileName)
            cmd.Parameters.AddWithValue("@Content", content)

            ' Execute command
            Using con
                con.Open()
                cmd.ExecuteScalar()
            End Using
        End Sub


        ''' <summary>
        ''' Returns a single virtual file
        ''' </summary>
        Public Shared Function FileSelect(ByVal virtualPath As String) As SqlVirtualFile
            Return New SqlVirtualFile(virtualPath)
        End Function

        ''' <summary>
        ''' Deletes a file from the database
        ''' </summary>
        Public Shared Sub FileDelete(ByVal virtualPath As String)
            ' Relativize path
            virtualPath = VirtualPathUtility.ToAppRelative(virtualPath)

            ' Break virtualPath
            Dim path As String = VirtualPathUtility.GetDirectory(virtualPath)
            Dim fileName As String = VirtualPathUtility.GetFileName(virtualPath)

            ' Initialize command
            Dim con As New SqlConnection(_connectionString)
            Dim commandText As String = "DELETE VirtualFiles WHERE Path=@Path AND Name=@Name"
            Dim cmd As New SqlCommand(commandText, con)

            ' Create parameters
            cmd.Parameters.AddWithValue("@Path", path)
            cmd.Parameters.AddWithValue("@Name", fileName)

            ' Execute command
            Using con
                con.Open()
                cmd.ExecuteNonQuery()
            End Using
        End Sub


        ''' <summary>
        ''' Check whether directory exists in database
        ''' </summary>
        Public Shared Function DirectoryExists(ByVal virtualPath As String) As Boolean
            ' Relativize path
            virtualPath = VirtualPathUtility.ToAppRelative(virtualPath)

            ' Initialize command
            Dim con As New SqlConnection(_connectionString)
            Dim commandText As String = "SELECT Path FROM VirtualDirectories WHERE Path=@Path"
            Dim cmd As New SqlCommand(commandText, con)

            ' Create parameter
            cmd.Parameters.AddWithValue("@Path", virtualPath)

            ' Execute command
            Dim result As Boolean
            Using con
                con.Open()
                Dim reader As SqlDataReader = cmd.ExecuteReader()
                result = reader.HasRows
            End Using
            Return result
        End Function


        ''' <summary>
        ''' Create a new directory
        ''' </summary>
        Public Shared Sub DirectoryInsert(ByVal virtualPath As String, ByVal path As String)
            ' Relativize path
            virtualPath = VirtualPathUtility.ToAppRelative(virtualPath)

            ' Initialize command
            Dim con As New SqlConnection(_connectionString)
            Dim commandText As String = "INSERT VirtualDirectories (Path,ParentPath) VALUES (@Path,@ParentPath)"
            Dim cmd As New SqlCommand(commandText, con)

            ' Create parameters
            cmd.Parameters.AddWithValue("@Path", VirtualPathUtility.Combine(virtualPath, path))
            cmd.Parameters.AddWithValue("@ParentPath", virtualPath)

            ' Execute command
            Using con
                con.Open()
                cmd.ExecuteNonQuery()
            End Using
        End Sub


        ''' <summary>
        ''' Deletes a directory
        ''' </summary>
        Public Shared Sub DirectoryDelete(ByVal virtualPath As String)
            ' Relativize path
            virtualPath = VirtualPathUtility.ToAppRelative(virtualPath)

            ' Initialize command
            Dim con As New SqlConnection(_connectionString)
            Dim commandText As String = "DELETE VirtualDirectories WHERE Path + '/'=@Path OR ParentPath=@Path"
            Dim cmd As New SqlCommand(commandText, con)

            ' Create parameters
            cmd.Parameters.AddWithValue("@Path", virtualPath)

            ' Execute command
            Using con
                con.Open()
                cmd.ExecuteNonQuery()
            End Using
        End Sub


        ''' <summary>
        ''' Get a directory
        ''' </summary>
        Public Shared Function DirectorySelect() As List(Of SqlVirtualDirectory)
            Dim dirs As New List(Of SqlVirtualDirectory)()

            ' Initialize command
            Dim con As New SqlConnection(_connectionString)
            Dim commandText As String = "SELECT Path FROM VirtualDirectories"
            Dim cmd As New SqlCommand(commandText, con)

            Using con
                con.Open()
                Dim reader As SqlDataReader = cmd.ExecuteReader()
                While reader.Read()
                    dirs.Add(New SqlVirtualDirectory(CType(reader("Path"), String)))
                End While
            End Using
            Return dirs
        End Function


        ''' <summary>
        ''' Get all files in a directory
        ''' </summary>
        Public Shared Function DirectorySelectFiles(ByVal virtualPath As String) As List(Of SqlVirtualFile)
            ' Relativize path
            virtualPath = VirtualPathUtility.ToAppRelative(virtualPath)

            ' Initialize command
            Dim con As SqlConnection = New SqlConnection(_connectionString)
            Dim commandText As String = "SELECT Path,Name FROM VirtualFiles " _
                & "WHERE Path=@Path ORDER BY Path"
            Dim cmd As New SqlCommand(commandText, con)

            ' Create parameter
            cmd.Parameters.AddWithValue("@Path", virtualPath)

            ' Execute command
            Dim files As New List(Of SqlVirtualFile)()
            Using con
                con.Open()
                Dim reader As SqlDataReader = cmd.ExecuteReader()
                While reader.Read()
                    Dim fullName As String = VirtualPathUtility.Combine(reader("Path").ToString(), reader("Name").ToString())
                    files.Add(New SqlVirtualFile(fullName))
                End While
            End Using

            Return files
        End Function

        ''' <summary>
        ''' Retrieves all subdirectories for a directory
        ''' </summary>
        Public Shared Function DirectorySelectDirectories(ByVal virtualPath As String) As List(Of SqlVirtualDirectory)
            ' Relativize path
            virtualPath = VirtualPathUtility.ToAppRelative(virtualPath)

            ' Initialize command
            Dim con As SqlConnection = New SqlConnection(_connectionString)
            Dim commandText As String = "SELECT Path FROM VirtualDirectories " _
                & "WHERE ParentPath=@Path ORDER BY Path"
            Dim cmd As New SqlCommand(commandText, con)

            ' Create parameters
            cmd.Parameters.AddWithValue("@Path", virtualPath)

            ' Execute command
            Dim dirs As New List(Of SqlVirtualDirectory)()
            Using con
                con.Open()
                Dim reader As SqlDataReader = cmd.ExecuteReader()
                While reader.Read()
                    dirs.Add(New SqlVirtualDirectory(reader("Path").ToString()))
                End While
            End Using
            Return dirs
        End Function

        ''' <summary>
        ''' Returns all files and subdirectories from a directory
        ''' </summary>
        Public Shared Function DirectorySelectChildren(ByVal virtualPath As String) As ArrayList
            Dim filesAndDirs As ArrayList = New ArrayList()

            Dim dirs As List(Of SqlVirtualDirectory) = DirectorySelectDirectories(virtualPath)
            For Each dir As SqlVirtualDirectory In dirs
                filesAndDirs.Add(dir)
            Next

            Dim files As List(Of SqlVirtualFile) = DirectorySelectFiles(virtualPath)
            For Each file As SqlVirtualFile In files
                filesAndDirs.Add(file)
            Next
            Return filesAndDirs
        End Function

    End Class
End Namespace

