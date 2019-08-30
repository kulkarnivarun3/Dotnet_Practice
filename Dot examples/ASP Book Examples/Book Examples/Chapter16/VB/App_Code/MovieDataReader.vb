Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class MovieDataReader

    Private ReadOnly _conString As String

    Public Function GetMovies() As SqlDataReader
        ' Create Connection
        Dim con As New SqlConnection(_conString)

        ' Create Command
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandText = "SELECT Id,Title,Director FROM Movies"

        ' Return DataReader
        con.Open()
        Return cmd.ExecuteReader(CommandBehavior.CloseConnection)
    End Function


    Public Sub New()
        _conString = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
    End Sub

End Class

