Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Collections.Generic

Public Class Movie3
    Private Shared ReadOnly _connectionString As String

    Private _id As Integer
    Private _title As String
    Private _director As String

    Public Property Id() As Integer
        Get
            Return _id
        End Get
        Set(ByVal Value As Integer)
            _id = value
        End Set
    End Property

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

    Public Sub Update(ByVal id As Integer, ByVal title As String, ByVal director As String)
        Dim con As New SqlConnection(_connectionString)
        Dim cmd As New SqlCommand("UPDATE MOVIES SET Title=@Title,Director=@Director WHERE Id=@Id", con)
        cmd.Parameters.AddWithValue("@Title", title)
        cmd.Parameters.AddWithValue("@Director", director)
        cmd.Parameters.AddWithValue("@Id", id)
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
        End Using
    End Sub

    Public Sub Delete(ByVal id As Integer)
        Dim con As New SqlConnection(_connectionString)
        Dim cmd As New SqlCommand("DELETE MOVIES WHERE Id=@Id", con)
        cmd.Parameters.AddWithValue("@Id", id)
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
        End Using
    End Sub

    Public Function GetAll() As List(Of Movie3)
        Dim results As New List(Of Movie3)()
        Dim con As New SqlConnection(_connectionString)
        Dim cmd As New SqlCommand("SELECT Id,Title,Director FROM Movies", con)
        Using con
            con.Open()
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            While reader.Read()
                Dim NewMovie As New Movie3()
                NewMovie.Id = CType(reader("Id"), Integer)
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

