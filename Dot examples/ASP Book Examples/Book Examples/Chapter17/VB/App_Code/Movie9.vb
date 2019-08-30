Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web
Imports System.Web.Configuration

Public Class Movie9

    Private dad As New SqlDataAdapter()

    Public Function GetAll() As DataTable
        Return CType(HttpContext.Current.Session("MoviesToEdit"), DataTable)
    End Function

    Public Sub Update(ByVal id As Integer, ByVal title As String, ByVal director As String)
        Dim movies As DataTable = CType(HttpContext.Current.Session("MoviestoEdit"), DataTable)
        Dim rowToEdit As DataRow = movies.Rows.Find(id)
        rowToEdit("title") = title
        rowToEdit("director") = director
    End Sub

    Public Sub RejectChanges()
        Dim movies As DataTable = CType(HttpContext.Current.Session("MoviestoEdit"), DataTable)
        movies.RejectChanges()
    End Sub

    Public Sub AcceptChanges()
        Dim movies As DataTable = CType(HttpContext.Current.Session("MoviestoEdit"), DataTable)
        dad.Update(movies)
        movies.AcceptChanges()
    End Sub

    Public Sub New()
        ' Create Data Adapter
        Dim connectionString As String = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
        dad = New SqlDataAdapter("SELECT Id,Title,Director FROM Movies", connectionString)
        Dim builder As New SqlCommandBuilder(dad)
        dad.UpdateBatchSize = 0

        Dim context As HttpContext = HttpContext.Current
        If IsNothing(context.Session("MoviesToEdit")) Then
            ' Add data to DataTable
            Dim dtblMovies As New DataTable()
            dad.Fill(dtblMovies)
            dtblMovies.PrimaryKey = New DataColumn() {dtblMovies.Columns("Id")}

            context.Session("MoviesToEdit") = dtblMovies
        End If
    End Sub
End Class
