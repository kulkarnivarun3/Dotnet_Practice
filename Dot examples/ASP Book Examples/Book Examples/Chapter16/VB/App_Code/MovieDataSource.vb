Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.UI.WebControls

Namespace AspNetUnleashed.Samples

    Public Class MovieDataSource
        Inherits ObjectDataSource

        Public Sub New()
            Me.TypeName = "AspNetUnleashed.Samples.MoviesComponent"
            Me.SelectMethod = "GetMovies"
        End Sub
    End Class

    Public Class MoviesComponent

        Private ReadOnly _conString As String

        Public Function GetMovies() As SqlDataReader
            ' Initialize connection     
            Dim con As New SqlConnection(_conString)

            ' Initialize command
            Dim cmd As New SqlCommand()
            cmd.Connection = con
            cmd.CommandText = "SELECT Title,Director,DateReleased FROM Movies"

            ' Execute command
            con.Open()
            Return cmd.ExecuteReader(CommandBehavior.CloseConnection)
        End Function

        Sub New()
            _conString = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
        End Sub
    End Class
End Namespace
