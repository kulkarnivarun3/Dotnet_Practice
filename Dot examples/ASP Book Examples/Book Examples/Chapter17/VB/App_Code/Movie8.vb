Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Collections.Generic

Public Class Movie8
    Private Shared ReadOnly _connectionString As String

    Public Function GetAll() As DataTable
        ' Initialize the DataAdapter
        Dim dad As New SqlDataAdapter("SELECT Title,Director FROM Movies", _connectionString)

        ' Create a DataTable
        Dim dtblMovies As New DataTable()

        ' Populate the DataTable
        dad.Fill(dtblMovies)

        ' Return results
        Return dtblMovies
    End Function

    Shared Sub New()
        _connectionString = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
    End Sub
End Class

