using System;
using System.Web;
using System.Net;
using System.IO;

namespace AspNetUnleashed
{
    public class RSSHandler : IHttpAsyncHandler
    {
        private HttpContext _context;
        private WebRequest _request;

        public IAsyncResult BeginProcessRequest(HttpContext context, AsyncCallback cb, object extraData)
        {
            // Store context
            _context = context;

            // Initiate call to RSS feed
            _request = WebRequest.Create("http://msdn.microsoft.com/asp.net/rss.xml");
            return _request.BeginGetResponse(cb, extraData);
        }

        public void EndProcessRequest(IAsyncResult result)
        {
            // Get the RSS feed
            string rss = String.Empty;
            WebResponse response = _request.EndGetResponse(result);
            using (response)
            {
                StreamReader reader = new StreamReader(response.GetResponseStream());
                rss = reader.ReadToEnd();
            }
            _context.Response.Write(rss);
        }

        public bool IsReusable
        {
            get { return true; }
        }

        public void ProcessRequest(HttpContext context)
        {
            throw new Exception("The ProcessRequest method is not implemented.");
        }
    }
}