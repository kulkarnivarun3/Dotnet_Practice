<%@ WebHandler Language="C#" Class="Atom10" %>

using System;
using System.Web;
using System.ServiceModel.Syndication;
using System.Xml;

public class Atom10 : IHttpHandler {
    
    
    public void ProcessRequest (HttpContext context) 
    {
        context.Response.ContentType = "application/atom+xml";
        
        SyndicationFeed feed = FeedHelper.GetFeed();
        Atom10FeedFormatter formatter = new Atom10FeedFormatter(feed);
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