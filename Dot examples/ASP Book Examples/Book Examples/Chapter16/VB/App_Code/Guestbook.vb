Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class Guestbook

    Private _conString As String

    Public Function GetEntries() As SqlDataReader
        ' Initialize connection     
        Dim con As New SqlConnection(_conString)

        ' Initialize command
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandText = "SELECT Id,IPAddress,Comment,EntryDate FROM Guestbook"

        ' Execute command
        con.Open()
        Return cmd.ExecuteReader(CommandBehavior.CloseConnection)
    End Function

    Public Sub AddEnTry(ByVal IPAddress As String, ByVal comment As String)
        ' Initialize connection     
        Dim con As New SqlConnection(_conString)

        ' Initialize command
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandText = "INSERT Guestbook (IPAddress,Comment)" _
            + " VALUES (@IPAddress, @Comment)"

        ' Add ADO.NET parameters
        cmd.Parameters.AddWithValue("@IPAddress", IPAddress)
        cmd.Parameters.AddWithValue("@Comment", comment)

        ' Execute command
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
        End Using
    End Sub

    Public Sub New()
        _conString = WebConfigurationManager.ConnectionStrings("Guestbook").ConnectionString
    End Sub

End Class
