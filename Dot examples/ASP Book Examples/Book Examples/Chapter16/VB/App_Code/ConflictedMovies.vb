Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class ConflictedMovies

    Private Shared ReadOnly _conString As String

    Public Shared Function GetMovies() As SqlDataReader
        ' Initialize connection     
        Dim con As New SqlConnection(_conString)

        ' Initialize command
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandText = "SELECT Id,Title,Director FROM Movies"

        ' Execute command
        con.Open()
        Return cmd.ExecuteReader(CommandBehavior.CloseConnection)
    End Function

    Public Shared Sub UpdateMovie(ByVal title As String, ByVal director As String, ByVal original_title As String, ByVal original_director As String, ByVal original_id As Integer)
        ' Initialize connection     
        Dim con As New SqlConnection(_conString)

        ' Initialize command
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandText = "UPDATE Movies SET Title=@Title,Director=@Director WHERE Id=@original_Id AND Title=@original_Title AND Director=@original_Director"

        ' Create parameters
        cmd.Parameters.AddWithValue("@Title", title)
        cmd.Parameters.AddWithValue("@Director", director)
        cmd.Parameters.AddWithValue("@original_Id", original_id)
        cmd.Parameters.AddWithValue("@original_Title", original_title)
        cmd.Parameters.AddWithValue("@original_Director", original_director)

        Using con
            con.Open()
            Dim rowsAffected As Integer = cmd.ExecuteNonQuery()
            If rowsAffected = 0 Then
                Throw New Exception("Could not update movie record")
            End If
        End Using
    End Sub

    Shared Sub New()
        _conString = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
    End Sub
End Class
