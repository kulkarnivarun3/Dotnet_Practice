Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Collections.Generic

Public Class DBDataLayer
    Private Shared ReadOnly _connectionString As String

    Public Function GetAll() As List(Of DBMovie)
        Dim results As New List(Of DBMovie)()
        Dim con As New SqlConnection(_connectionString)
        Dim cmd As New SqlCommand("SELECT Movie FROM DBMovies", con)
        Using con
            con.Open()
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            While reader.Read()
                Dim NewMovie As DBMovie = CType(reader("Movie"), DBMovie)
                results.Add(NewMovie)
            End While
        End Using
        Return results
    End Function

    Public Sub Insert(ByVal movieToAdd As DBMovie)
        Dim con As New SqlConnection(_connectionString)
        Dim cmd As New SqlCommand("INSERT DBMovies (Movie) VALUES (@Movie)", con)
        cmd.Parameters.Add("@Movie", SqlDbType.Udt)
        cmd.Parameters("@Movie").UdtTypeName = "DBMovie"
        cmd.Parameters("@Movie").Value = movieToAdd
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
        End Using
    End Sub


    Shared Sub New()
        _connectionString = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
    End Sub
End Class

