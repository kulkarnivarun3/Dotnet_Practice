Imports System
Imports System.Web
Imports System.Xml
Imports System.Web.Caching
Imports System.Text.RegularExpressions
 
Namespace AspNetUnleashed
 
    Public Class UrlRemapper
        Implements IHttpModule

        Public Sub Init(ByVal app As HttpApplication) Implements IHttpModule.Init
            AddHandler app.BeginRequest, AddressOf app_BeginRequest
        End Sub

        Public Sub app_BeginRequest(ByVal s As Object, ByVal e As EventArgs)
            ' Get HTTP Context
            Dim app As HttpApplication = CType(s, HttpApplication)
            Dim context As HttpContext = app.Context

            ' Get current URL
            Dim currentUrl As String = context.Request.AppRelativeCurrentExecutionFilePath

            ' Get URL Mappings
            Dim urlMappings As XmlDocument = GetUrlMappings(context)

            ' Compare current URL against each URL from mappings file
            Dim nodes As XmlNodeList = urlMappings.SelectNodes("//add")
            For Each node As XmlNode In nodes
                Dim url As String = node.Attributes("url").Value
                Dim mappedUrl As String = node.Attributes("mappedUrl").Value
                If Regex.Match(currentUrl, url, RegexOptions.IgnoreCase).Success Then
                    context.RewritePath(mappedUrl)
                End If
            Next
        End Sub

        Private Function GetUrlMappings(ByVal context As HttpContext) As XmlDocument
            Dim urlMappings As XmlDocument = CType(context.Cache("UrlMappings"), XmlDocument)
            If urlMappings Is Nothing Then
                urlMappings = New XmlDocument()
                Dim path As String = context.Server.MapPath("~/UrlMappings.config")
                urlMappings.Load(path)
                Dim fileDepend As CacheDependency = New CacheDependency(path)
                context.Cache.Insert("UrlMappings", urlMappings, fileDepend)
            End If
            Return urlMappings
        End Function

        Public Sub Dispose() Implements System.Web.IHttpModule.Dispose
        End Sub

    End Class
End Namespace
