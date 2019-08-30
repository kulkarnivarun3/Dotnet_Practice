using System;
using System.Web;

namespace AspNetUnleashed
{
    public class QueryStringAuthenticationModule : IHttpModule
    {
        public void Init(HttpApplication app)
        {
            app.AuthorizeRequest += new EventHandler(AuthorizeRequest);
        }

        private void AuthorizeRequest(Object sender, EventArgs e)
        {
            // Get context
            HttpApplication app = (HttpApplication)sender;
            HttpContext context = app.Context;

            // If the request is for Login.aspx, exit
            string path = context.Request.AppRelativeCurrentExecutionFilePath;
            if (String.Compare(path, "~/login.aspx", true) == 0)
                return;

            // Check for password
            bool authenticated = false;
            if (context.Request.QueryString["password"] != null)
            {
                if (context.Request.QueryString["password"] == "secret")
                    authenticated = true;
            }

            // If not authenticated, redirect to login.aspx
            if (!authenticated)
                context.Response.Redirect("~/Login.aspx");
        }

        public void Dispose() { }
    }
}
