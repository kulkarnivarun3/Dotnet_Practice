<%@ WebHandler Language="VB" Class="PublicSiteMap" %>
Imports System
Imports System.Web
Imports System.Xml
Imports System.Text
Imports System.IO
 
Public Class PublicSiteMap
    Implements IHttpHandler
 
    Private _xmlWriter As XmlWriter
 
    Public Sub ProcessRequest(ByVal context As HttpContext)Implements IHttpHandler.ProcessRequest
        context.Response.ContentType = "text/xml"
 
        Dim settings As New XmlWriterSettings()
        settings.Encoding = Encoding.UTF8
        settings.Indent = True
        _xmlWriter = XmlWriter.Create(context.Response.OutputStream, settings)
        _xmlWriter.WriteStartDocument()
        _xmlWriter.WriteStartElement("urlset", "http://www.google.com/schemas/sitemap/0.84")
 
        ' Add root node
        AddUrl(SiteMap.RootNode)
 
        ' Add all other nodes
        Dim nodes As SiteMapNodeCollection = SiteMap.RootNode.GetAllNodes()
        For Each node As SiteMapNode In nodes
            AddUrl(node)
        Next
 
        _xmlWriter.WriteEndElement()
        _xmlWriter.WriteEndDocument()
        _xmlWriter.Flush()
    End Sub
 
    Private  Sub AddUrl(ByVal node As SiteMapNode)
        ' Skip empty Urls
        If String.IsNullOrEmpty(node.Url) Then
            Return
        End If
        ' Skip remote nodes
        If node.Url.StartsWith("http",True,Nothing) Then
            Return
        End If
        ' Open url tag
        _xmlWriter.WriteStartElement("url")
        ' Write location
        _xmlWriter.WriteStartElement("loc")
        _xmlWriter.WriteString(GetFullUrl(node.Url))
        _xmlWriter.WriteEndElement()
        ' Write last modified
        _xmlWriter.WriteStartElement("lastmod")
        _xmlWriter.WriteString(GetLastModified(node.Url))
        _xmlWriter.WriteEndElement()
        ' Close url tag        
        _xmlWriter.WriteEndElement()
    End Sub
 
    Private Function GetFullUrl(ByVal url As String) As String
        Dim context As HttpContext =  HttpContext.Current 
        Dim server As String =  context.Request.Url.GetComponents(UriComponents.SchemeAndServer,UriFormat.UriEscaped) 
        Return Combine(server,url)
    End Function
 
    Private Function Combine(ByVal baseUrl As String, ByVal url As String) As String
        baseUrl = baseUrl.TrimEnd(New Char() {"/"c})
        url = url.TrimStart(New Char() {"/"c})
        Return baseUrl + "/" + url
    End Function
 
    Private Function GetLastModified(ByVal url As String) As String
        Dim context As HttpContext =  HttpContext.Current 
        Dim physicalPath As String =  context.Server.MapPath(url) 
        Return File.GetLastWriteTimeUtc(physicalPath).ToString("s") & "Z"
    End Function
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return True
        End Get
    End Property
End Class

