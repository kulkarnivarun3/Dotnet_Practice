Imports System
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class MoviesByCategory

    Private ReadOnly _conString As String
    Private ReadOnly _movieCategory As String

    Public Function GetMovies() As SqlDataReader
        ' Initialize connection     
        Dim con As New SqlConnection(_conString)

        ' Initialize command
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandText = "SELECT Title,Director,DateReleased FROM Movies" _
            + " JOIN MovieCategories ON Movies.CategoryId=MovieCategories.Id" _
            + " WHERE MovieCategories.Name=@CategoryName"

        ' Create ADO.NET parameters
        cmd.Parameters.AddWithValue("@CategoryName", _movieCategory)

        ' Execute command
        con.Open()
        Return cmd.ExecuteReader(CommandBehavior.CloseConnection)
    End Function

    Public Sub New(ByVal movieCategory As String)
        _movieCategory = movieCategory
        _conString = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
    End Sub
End Class

