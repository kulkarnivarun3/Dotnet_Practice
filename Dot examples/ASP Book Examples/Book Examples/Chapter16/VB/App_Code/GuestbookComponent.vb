Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class GuestbookComponent

    Private _conString As String

    Public Function GetEntries() As SqlDataReader
        ' Initialize connection     
        Dim con As New SqlConnection(_conString)

        ' Initialize command
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandText = "SELECT Id,Username,Comment,EntryDate FROM Guestbook"

        ' Execute command
        con.Open()
        Return cmd.ExecuteReader(CommandBehavior.CloseConnection)
    End Function


    Public Sub AddEnTry(ByVal username As String, ByVal comment As String)
        ' Initialize connection     
        Dim con As New SqlConnection(_conString)

        ' Initialize command
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandText = "INSERT Guestbook (Username,Comment)" _
            + " VALUES (@Username, @Comment)"

        ' Add ADO.NET parameters
        cmd.Parameters.AddWithValue("@Username", username)
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

