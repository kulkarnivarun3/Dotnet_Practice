Imports System
Imports System.Collections
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class Movie
    Public Shared Function Search(ByVal query As String) As ArrayList
        Dim results As New ArrayList()
        Dim conString As String = WebConfigurationManager.ConnectionStrings("con").ConnectionString
        Dim commandText As String = "SELECT Title FROM Movie WHERE Title LIKE @query + '%'"
        Dim con As New SqlConnection(conString)
        Dim cmd As New SqlCommand(commandText, con)
        cmd.Parameters.AddWithValue("@query", query)
        Using con
            con.Open()
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            While reader.Read()
                results.Add(CType(reader("Title"), String))
            End While
        End Using
        Return results
    End Function


End Class
