<%@ WebHandler Language="VB" Class="FileHandler" %>
 
Imports System
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient
 
Public Class FileHandler
    Implements IHttpHandler
 
    Const conString As String = "Server=.\SQLExpress;Integrated Security=True;AttachDbFileName=|DataDirectory|FilesDB.mdf;User Instance=True"
 
    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        context.Response.ContentType = "application/msword"
 
        Dim con As SqlConnection = New SqlConnection(conString)
        Dim cmd As SqlCommand = New SqlCommand("SELECT FileBytes FROM Files WHERE Id=@Id", con)
        cmd.Parameters.AddWithValue("@Id", context.Request("Id"))
        Using con
            con.Open()
            Dim file() As Byte = CType(cmd.ExecuteScalar(), Byte())
            context.Response.BinaryWrite(file)
        End Using
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property
 
End Class
