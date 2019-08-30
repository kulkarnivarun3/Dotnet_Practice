<%@ WebHandler Language="VB" Class="AdHandler" %>

Imports System
Imports System.Web
Imports System.Data
imports System.Data.SqlClient

Public Class AdHandler
    Implements IHttpHandler

    Const conString As String = "Server=.\SQLExpress;Integrated Security=True;AttachDbFileName=|DataDirectory|AdListDB.mdf;User Instance=True"
    
    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Dim AdId As Integer = Int32.Parse(context.Request("Id"))

        Dim con As New SqlConnection(conString)
        Dim navigateUrl As String = String.Empty
        Using con
            con.Open()
            UpdateTransferStats(AdId, con)
            navigateUrl = GetNavigateUrl(AdId, con)
        End Using

        If Not String.IsNullOrEmpty(navigateUrl) Then
            context.Response.Redirect(navigateUrl)
        End If
    End Sub

    Sub UpdateTransferStats(ByVal advertisementId As Integer, ByVal con As SqlConnection)
        Dim cmdText As String = "INSERT AdStats (AdId, EntryDate, Type) VALUES " & _
            "(@AdId, GetDate(), 1)"
        Dim cmd As New SqlCommand(cmdText, con)
        cmd.Parameters.AddWithValue("@AdId", advertisementId)
        cmd.ExecuteNonQuery()
    End Sub

    Function GetNavigateUrl(ByVal advertisementId As Integer, ByVal con As SqlConnection) As String
        Dim cmdText As String = "SELECT NavigateUrl FROM AdList WHERE Id=@AdId"
        Dim cmd As New SqlCommand(cmdText, con)
        cmd.Parameters.AddWithValue("@AdId", advertisementId)
        Return cmd.ExecuteScalar().ToString()
    End Function
    
    
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class