Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Collections.Generic

Public Class Movie7
    Private Shared ReadOnly _connectionString As String

    Public Function GetAll() As SqlDataReader
        Dim con As New SqlConnection(_connectionString)
        Dim cmd As New SqlCommand("SELECT Title,Director FROM Movies", con)
        con.Open()
        Return cmd.ExecuteReader(CommandBehavior.CloseConnection)
    End Function

    Shared Sub New()
        _connectionString = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
    End Sub
End Class

