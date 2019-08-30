Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Collections.Generic

Public Class RandomDataLayer
    Private Shared ReadOnly _connectionString As String

    Public Function GetRandomMovies() As List(Of String)
        Dim results As New List(Of String)()
        Dim con As New SqlConnection(_connectionString)
        Dim cmd As New SqlCommand("GetRandomRows", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@rowsToReturn", 5)
        Using con
            con.Open()
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            While reader.Read()
                results.Add(CType(reader("Title"), String))
            End While
        End Using
        Return results
    End Function


    Public Shared Function GetRandomMovie() As String
        Dim result As String = String.Empty
        Dim con As New SqlConnection(_connectionString)
        Dim cmd As New SqlCommand("GetRandomRow", con)
        cmd.CommandType = CommandType.StoredProcedure
        Using con
            con.Open()
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            If reader.Read() Then
                result = CType(reader("Title"), String)
            End If
        End Using
        Return result
    End Function

    Shared Sub New()
        _connectionString = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
    End Sub

End Class
