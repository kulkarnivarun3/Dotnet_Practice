Imports System
Imports System.Web
Imports System.Net
Imports System.IO

Namespace AspNetUnleashed
    Public Class RSSHandler
        Implements IHttpAsyncHandler

        Private _context As HttpContext
        Private _request As WebRequest

        Public Function BeginProcessRequest(ByVal context As HttpContext, ByVal cb As AsyncCallback, ByVal extraData As Object) As IAsyncResult Implements IHttpAsyncHandler.BeginProcessRequest
            ' Store context
            _context = context

            ' Initiate call to RSS feed
            _request = WebRequest.Create("http://msdn.microsoft.com/asp.net/rss.xml")
            Return _request.BeginGetResponse(cb, extraData)
        End Function

        Public Sub EndProcessRequest(ByVal result As IAsyncResult) Implements IHttpAsyncHandler.EndProcessRequest
            ' Get the RSS feed
            Dim rss As String = String.Empty
            Dim response As WebResponse = _request.EndGetResponse(result)
            Using response
                Dim reader As New StreamReader(response.GetResponseStream())
                rss = reader.ReadToEnd()
            End Using
            _context.Response.Write(rss)
        End Sub

        Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
            Get
                Return True
            End Get
        End Property

        Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
            Throw New Exception("The ProcessRequest method is not implemented.")
        End Sub
    End Class
End Namespace
