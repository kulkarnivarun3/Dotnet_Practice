Imports System
Imports System.Collections
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class Message

    Private _Postedby As String

    Public Property PostedBy() As String
        Get
            Return _Postedby
        End Get
        Set(ByVal value As String)
            _PostedBy = value
        End Set
    End Property

    Private _Post As String

    Public Property Post() As String
        Get
            Return _Post
        End Get
        Set(ByVal value As String)
            _Post = value
        End Set
    End Property


    Public Shared Function [Select]() As ArrayList
        Dim results As New ArrayList()
        Dim conString As String = WebConfigurationManager.ConnectionStrings("con").ConnectionString
        Dim commandText As String = "SELECT PostedBy, Post FROM Message ORDER BY Id DESC"
        Dim con As New SqlConnection(conString)
        Dim cmd As New SqlCommand(commandText, con)
        Using con
            con.Open()
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            While reader.Read()
                results.Add(New Message(reader))
            End While
        End Using
        Return results
    End Function


    Public Sub New(ByVal reader As SqlDataReader)
        PostedBy = CType(reader("PostedBy"), String)
        Post = CType(reader("Post"), String)
    End Sub

End Class
