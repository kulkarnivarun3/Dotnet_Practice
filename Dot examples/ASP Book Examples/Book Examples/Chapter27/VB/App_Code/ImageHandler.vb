Imports System
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Namespace AspNetUnleashed

    Public Class ImageHandler
        Implements IHttpHandler

        Const connectionStringName As String = "Images"

        Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
            ' Don't buffer response
            context.Response.Buffer = False

            ' Get file name
            Dim fileName As String = VirtualPathUtility.GetFileName(context.Request.Path)

            ' Get image from database
            Dim conString As String = WebConfigurationManager.ConnectionStrings(connectionStringName).ConnectionString
            Dim con As New SqlConnection(conString)
            Dim cmd As New SqlCommand("SELECT Image FROM Images WHERE FileName=@FileName", con)
            cmd.Parameters.AddWithValue("@fileName", fileName)
            Using con
                con.Open()
                Dim reader As SqlDataReader = cmd.ExecuteReader(CommandBehavior.SequentialAccess)
                If reader.Read() Then
                    Dim bufferSize As Integer = 8040
                    Dim chunk(bufferSize) As Byte
                    Dim retCount As Long
                    Dim startIndex As Long = 0
                    retCount = reader.GetBytes(0, startIndex, chunk, 0, bufferSize)
                    While retCount = bufferSize
                        context.Response.BinaryWrite(chunk)
                        startIndex += bufferSize
                        retCount = reader.GetBytes(0, startIndex, chunk, 0, bufferSize)
                    End While
                    Dim actualChunk() As Byte = New Byte(retCount - 1) {}
                    Buffer.BlockCopy(chunk, 0, actualChunk, 0, CType(retCount - 1, Integer))
                    context.Response.BinaryWrite(actualChunk)
                End If
            End Using
        End Sub

        Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
            Get
                Return True
            End Get
        End Property
    End Class
End Namespace