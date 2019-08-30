Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Collections.Generic

Public Class AsyncDataLayer

    Private Shared ReadOnly _connectionString As String
    Private _cmdMovies As SqlCommand

    Public Function BeginGetMovies(ByVal callback As AsyncCallback, ByVal state As Object) As IAsyncResult
        Dim con As New SqlConnection(_connectionString)
        _cmdMovies = New SqlCommand("SELECT Title,Director FROM Movies", con)
        con.Open()
        Return _cmdMovies.BeginExecuteReader(callback, state, CommandBehavior.CloseConnection)
    End Function

    Public Function EndGetMovies(ByVal result As IAsyncResult) As List(Of AsyncDataLayer.Movie)
        Dim results As New List(Of AsyncDataLayer.Movie)()
        Dim reader As SqlDataReader = _cmdMovies.EndExecuteReader(result)
        While reader.Read()
            Dim NewMovie As New AsyncDataLayer.Movie()
            NewMovie.Title = CType(reader("Title"), String)
            NewMovie.Director = CType(reader("Director"), String)
            results.Add(NewMovie)
        End While
        Return results
    End Function

    Shared Sub New()
        _connectionString = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
        _connectionString &= ";Asynchronous Processing=true"
    End Sub

    Public Class Movie
        Private _title As String
        Private _director As String

        Public Property Title() As String
            Get
                Return _title
            End Get
            Set(ByVal Value As String)
                _title = Value
            End Set
        End Property

        Public Property Director() As String
            Get
                Return _director
            End Get
            Set(ByVal Value As String)
                _director = Value
            End Set
        End Property
    End Class
End Class

