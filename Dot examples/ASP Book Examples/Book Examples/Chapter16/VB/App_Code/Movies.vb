Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class Movies

    Private ReadOnly _conString As String

    Public Sub UpdateMovie(ByVal id As Integer, ByVal title As String, ByVal director As String, ByVal dateReleased As DateTime)
        ' Create Command
        Dim con As New SqlConnection(_conString)
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandText = "UPDATE Movies SET Title=@Title,Director=@Director,DateReleased=@DateReleased WHERE Id=@Id"

        ' Add parameters
        cmd.Parameters.AddWithValue("@Title", title)
        cmd.Parameters.AddWithValue("@Director", director)
        cmd.Parameters.AddWithValue("@DateReleased", dateReleased)
        cmd.Parameters.AddWithValue("@Id", id)

        ' Execute command
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
        End Using
    End Sub

    Public Function GetMovies() As SqlDataReader
        ' Create Connection
        Dim con As New SqlConnection(_conString)

        ' Create Command
        Dim cmd As SqlCommand = New SqlCommand()
        cmd.Connection = con
        cmd.CommandText = "SELECT Id,Title,Director,DateReleased FROM Movies"

        ' Return DataReader
        con.Open()
        Return cmd.ExecuteReader(CommandBehavior.CloseConnection)
    End Function

    Public Sub New()
        _conString = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
    End Sub

End Class

