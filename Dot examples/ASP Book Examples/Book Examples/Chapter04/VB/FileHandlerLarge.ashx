<%@ WebHandler Language="VB" Class="FileHandlerLarge" %>

Imports System
Imports System.Web
Imports System.Data
imports System.Data.SqlClient

Public Class FileHandlerLarge
    Implements IHttpHandler

    Const conString As String = "Server=.\SQLExpress;Integrated Security=True;AttachDbFileName=|DataDirectory|FilesDB.mdf;User Instance=True"
    
    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        context.Response.Buffer = False
        context.Response.ContentType = "application/msword"
        
        Dim con As New SqlConnection(conString)
        Dim cmd As New SqlCommand("SELECT FileBytes FROM Files WHERE Id=@Id", con)
        cmd.Parameters.AddWithValue("@Id", context.Request("Id"))
        Using con
            con.Open()
            Dim reader As SqlDataReader = cmd.ExecuteReader(CommandBehavior.SequentialAccess)
            If reader.Read() Then
                Dim bufferSize As Integer = 8040
                Dim chunk(bufferSize - 1) As Byte
                Dim retCount As Long
                Dim startIndex As Long = 0

                retCount = reader.GetBytes(0, startIndex, chunk, 0, bufferSize)
                
                While retCount = bufferSize
                    context.Response.BinaryWrite(chunk)

                    startIndex += bufferSize
                    retCount = reader.GetBytes(0, startIndex, chunk, 0, bufferSize)
                End While

                Dim actualChunk(retCount - 1) As Byte
                Buffer.BlockCopy(chunk, 0, actualChunk, 0, retCount - 1)
                context.Response.BinaryWrite(actualChunk)
                               
            End If
        End Using
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class