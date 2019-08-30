<%@ Application Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<script runat="server">

    public override string GetVaryByCustomString(HttpContext context, string custom)
    {
        if (String.Compare(custom, "css") == 0)
        {
            return Request.Browser.SupportsCss.ToString();
        }
        return base.GetVaryByCustomString(context, custom);
    }

    void Application_Start(object sender, EventArgs e)
    {
        // Enable Push SQL cache dependencies
        //string conString = WebConfigurationManager.ConnectionStrings["MyMovies"].ConnectionString;
        //SqlDependency.Start(conString);

        
        
        HttpContext context = HttpContext.Current;
        context.Cache.Insert(
            "MovieKey",
            DateTime.Now,
            null,
            DateTime.MaxValue,
            Cache.NoSlidingExpiration,
            CacheItemPriority.NotRemovable,
            null); 
    }
</script>
