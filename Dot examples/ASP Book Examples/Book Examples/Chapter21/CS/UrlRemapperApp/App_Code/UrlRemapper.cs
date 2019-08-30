using System;
using System.Web;
using System.Xml;
using System.Web.Caching;
using System.Text.RegularExpressions;

namespace AspNetUnleashed
{

    public class UrlRemapper : IHttpModule
    {
        public void Init(HttpApplication app)
        {
            app.BeginRequest += new EventHandler(app_BeginRequest);
        }

        public void app_BeginRequest(Object s, EventArgs e)
        {
            // Get HTTP Context
            HttpApplication app = (HttpApplication)s;
            HttpContext context = app.Context;

            // Get current URL
            string currentUrl = context.Request.AppRelativeCurrentExecutionFilePath;
            
            // Get URL Mappings
            XmlDocument urlMappings = GetUrlMappings(context);

            // Compare current URL against each URL from mappings file
            XmlNodeList nodes = urlMappings.SelectNodes("//add");
            foreach (XmlNode node in nodes)
            {
                string url = node.Attributes["url"].Value;
                string mappedUrl = node.Attributes["mappedUrl"].Value;
                if (Regex.Match(currentUrl, url, RegexOptions.IgnoreCase).Success)
                    context.RewritePath(mappedUrl);
            }
        }

        private XmlDocument GetUrlMappings(HttpContext context)
        {
            XmlDocument urlMappings = (XmlDocument)context.Cache["UrlMappings"];
            if (urlMappings == null)
            {
                urlMappings = new XmlDocument();
                string path = context.Server.MapPath("~/UrlMappings.config");
                urlMappings.Load(path);
                CacheDependency fileDepend = new CacheDependency(path);
                context.Cache.Insert("UrlMappings", urlMappings, fileDepend);

            }
            return urlMappings;
        }

        public void Dispose() { }

    }
}