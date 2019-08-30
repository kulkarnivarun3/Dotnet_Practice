<%@ WebHandler Language="vb" Class="Atom10" %>
 
Imports System
Imports System.Web
Imports System.ServiceModel.Syndication
Imports System.Xml
 
Public Class Atom10
	 Implements IHttpHandler
 
 
    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        context.Response.ContentType = "application/atom+xml"
 
        Dim feed As SyndicationFeed = FeedHelper.GetFeed()
        Dim formatter As Atom10FeedFormatter = New Atom10FeedFormatter(feed)
        Dim xmlWriter As XmlTextWriter = New XmlTextWriter(context.Response.Output)
        Using xmlWriter
            formatter.WriteTo(xmlWriter)
            xmlWriter.Flush()
        End Using
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property
 
End Class

