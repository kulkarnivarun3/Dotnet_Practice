<%@ WebHandler Language="C#" Class="PublicSiteMap" %>
using System;
using System.Web;
using System.Xml;
using System.Text;
using System.IO;

public class PublicSiteMap : IHttpHandler {

    private XmlWriter _xmlWriter;
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/xml";

        XmlWriterSettings settings = new XmlWriterSettings();
        settings.Encoding = Encoding.UTF8;
        settings.Indent = true;
        _xmlWriter = XmlWriter.Create(context.Response.OutputStream,settings);
        _xmlWriter.WriteStartDocument();
        _xmlWriter.WriteStartElement("urlset","http://www.google.com/schemas/sitemap/0.84");
        
        // Add root node
        AddUrl(SiteMap.RootNode);
        
        // Add all other nodes
        SiteMapNodeCollection nodes = SiteMap.RootNode.GetAllNodes();
        foreach (SiteMapNode node in nodes)
            AddUrl(node);
        
        _xmlWriter.WriteEndElement();
        _xmlWriter.WriteEndDocument();
        _xmlWriter.Flush();
    }

    private void AddUrl(SiteMapNode node)
    {
        // Skip empty Urls
        if (String.IsNullOrEmpty(node.Url))
            return;
        // Skip remote nodes
        if (node.Url.StartsWith("http", true, null))
            return;
        // Open url tag
        _xmlWriter.WriteStartElement("url");
        // Write location
        _xmlWriter.WriteStartElement("loc");
        _xmlWriter.WriteString(GetFullUrl(node.Url));
        _xmlWriter.WriteEndElement();
        // Write last modified
        _xmlWriter.WriteStartElement("lastmod");
        _xmlWriter.WriteString(GetLastModified(node.Url));
        _xmlWriter.WriteEndElement();
        // Close url tag        
        _xmlWriter.WriteEndElement();
    }

    private string GetFullUrl(string url)
    {
        HttpContext context = HttpContext.Current;
        string server = context.Request.Url.GetComponents(UriComponents.SchemeAndServer,UriFormat.UriEscaped);
        return Combine(server, url);
    }

    private string Combine(string baseUrl, string url)
    {
        baseUrl = baseUrl.TrimEnd(new char[] {'/'});
        url = url.TrimStart(new char[] { '/' });
        return baseUrl + "/" + url;
    }
    
    private string GetLastModified(string url)
    {
        HttpContext context = HttpContext.Current;
        string physicalPath = context.Server.MapPath(url);
        return File.GetLastWriteTimeUtc(physicalPath).ToString("s") + "Z";
    }
       
    public bool IsReusable {
        get {
            return true;
        }
    }
}