Imports System
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class InsertMovie

    Private Shared ReadOnly _conString As String

    Public Shared Function GetMovies() As SqlDataReader
        ' Initialize connection     
        Dim con As New SqlConnection(_conString)

        ' Initialize command
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandText = "SELECT Id,Title,Director FROM Movies"

        ' Execute command
        con.Open()
        Return cmd.ExecuteReader(CommandBehavior.CloseConnection)
    End Function

    Public Shared Sub Insert(ByVal title As String, ByVal director As String)
        ' Initialize connection     
        Dim con As New SqlConnection(_conString)

        ' Initialize command
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandText = "INSERT Movies (Title,Director)" _
            + " VALUES (@Title,@Director)"

        ' Add ADO.NET parameters
        cmd.Parameters.AddWithValue("@Title", title)
        cmd.Parameters.AddWithValue("@Director", director)

        ' Execute command
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
        End Using
    End Sub

    Shared Sub New()
        _conString = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
    End Sub

End Class

