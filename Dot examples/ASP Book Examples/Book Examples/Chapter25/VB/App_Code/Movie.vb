Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class Movie
    Public Shared Function GetMovies() As DataTable
        Dim conString As String = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
        Dim dad As New SqlDataAdapter("SELECT Title,Director FROM Movies", conString)
        Dim movies As New DataTable()
        dad.Fill(movies)
        Return movies
    End Function
End Class

