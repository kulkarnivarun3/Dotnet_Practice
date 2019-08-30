Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class MovieCategories

    Private ReadOnly _conString As String

    Public Function GetMovies(ByVal categoryId As Integer) As SqlDataReader
        ' Create Connection
        Dim con As New SqlConnection(_conString)

        ' Create Command
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandText = "SELECT Id,Title,Director,DateReleased " _
            + " FROM Movies WHERE CategoryId=@CategoryId"

        ' Add parameters
        cmd.Parameters.AddWithValue("@CategoryId", categoryId)

        ' Return DataReader
        con.Open()
        Return cmd.ExecuteReader(CommandBehavior.CloseConnection)
    End Function

    Public Function GetCategories() As SqlDataReader
        ' Create Connection
        Dim con As New SqlConnection(_conString)

        ' Create Command
        Dim cmd As SqlCommand = New SqlCommand()
        cmd.Connection = con
        cmd.CommandText = "SELECT Id,Name FROM MovieCategories"

        ' Return DataReader
        con.Open()
        Return cmd.ExecuteReader(CommandBehavior.CloseConnection)
    End Function

    Public Sub New()
        _conString = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
    End Sub

End Class

