Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class MovieUIPaging

    Private ReadOnly _conString As String

    Public Function GetMoviesDataSet() As DataSet
        ' Create DataAdapter
        Dim commandText As String = "SELECT Id,Title,Director FROM Movies"
        Dim dad As SqlDataAdapter = New SqlDataAdapter(commandText, _conString)

        ' Return DataSet
        Dim dstMovies As DataSet = New DataSet()
        Using dad
            dad.Fill(dstMovies)
        End Using
        Return dstMovies
    End Function

    Public Sub New()
        _conString = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
    End Sub

End Class
