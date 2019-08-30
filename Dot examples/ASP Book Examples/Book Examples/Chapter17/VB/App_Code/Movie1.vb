Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Collections.Generic

Public Class Movie1
    Private Shared ReadOnly _connectionString As String

    Private _title As String
    Private _director As String

    Public Property Title() As String
        Get
            Return _title
        End Get
        Set(ByVal Value As String)
            _title = value
        End Set
    End Property

    Public Property Director() As String
        Get
            Return _director
        End Get
        Set(ByVal Value As String)
            _director = value
        End Set
    End Property

    Public Function GetAll() As List(Of Movie1)
        Dim results As New List(Of Movie1)
        Dim con As New SqlConnection(_connectionString)
        Dim cmd As New SqlCommand("SELECT Title,Director FROM Movies", con)
        Using con
            con.Open()
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            While reader.Read()
                Dim NewMovie As New Movie1()
                NewMovie.Title = CType(reader("Title"), String)
                NewMovie.Director = CType(reader("Director"), String)
                results.Add(NewMovie)
            End While
        End Using
        Return results
    End Function

    Shared Sub New()
        _connectionString = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
    End Sub
End Class

