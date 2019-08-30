<%@ WebHandler Language="C#" Class="Rss20" %>

using System;
using System.Web;
using System.ServiceModel.Syndication;
using System.Xml;

public class Rss20 : IHttpHandler {
    
    
    public void ProcessRequest (HttpContext context) 
    {
        context.Response.ContentType = "application/rss+xml";
    
   
        SyndicationFeed feed = FeedHelper.GetFeed();    
        Rss20FeedFormatter formatter = new Rss20FeedFormatter(feed);
        XmlTextWriter xmlWriter = new XmlTextWriter(context.Response.Output);
        using (xmlWriter)
        {
            formatter.WriteTo(xmlWriter);
            xmlWriter.Flush();
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}