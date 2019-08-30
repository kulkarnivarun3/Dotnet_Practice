Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class MovieDataSet

    Private ReadOnly _conString As String

    Public Function GetMovies() As DataSet
        ' Create DataAdapter
        Dim commandText As String = "SELECT Id,Title,Director FROM Movies"
        Dim dad As New SqlDataAdapter(commandText, _conString)

        ' Return DataSet
        Dim dstMovies As New DataSet()
        Using dad
            dad.Fill(dstMovies)
        End Using
        Return dstMovies
    End Function

    Public Sub New()
        _conString = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
    End Sub

End Class

