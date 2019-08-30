Imports System
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class FilterMovies

    Private ReadOnly _conString As String

    Public Function GetMovies() As DataSet
        ' Initialize DataAdapter
        Dim commandText As String = "SELECT Title,Director,CategoryId FROM Movies"
        Dim dad As SqlDataAdapter = New SqlDataAdapter(commandText, _conString)

        ' Return DataSet
        Dim dstMovies As New DataSet()
        Using dad
            dad.Fill(dstMovies)
        End Using
        Return dstMovies
    End Function

    Public Function GetMovieCategories() As DataSet
        ' Initialize DataAdapter
        Dim commandText As String = "SELECT Id,Name FROM MovieCategories"
        Dim dad As New SqlDataAdapter(commandText, _conString)

        ' Return DataSet
        Dim dstCategories As New DataSet()
        Using dad
            dad.Fill(dstCategories)
        End Using
        Return dstCategories
    End Function

    Public Sub New()
        _conString = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
    End Sub
End Class
