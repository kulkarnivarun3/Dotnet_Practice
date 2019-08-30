<%@ Application Language="C#" %>
<%@ Import Namespace="System.IO" %>
<script runat="server">

    void Application_Start(Object sender, EventArgs e) 
    {
        SiteMap.SiteMapResolve += new SiteMapResolveEventHandler(SiteMap_SiteMapResolve);
    }

    SiteMapNode SiteMap_SiteMapResolve(object sender, SiteMapResolveEventArgs e)
    {
        if (SiteMap.CurrentNode == null)
        {
            string url = e.Context.Request.Path;
            string title = Path.GetFileNameWithoutExtension(url);
            SiteMapNode newNode = new SiteMapNode(e.Provider, url, url, title);
            newNode.ParentNode = SiteMap.RootNode;
            return newNode; 
        }
        return SiteMap.CurrentNode;
    }
</script>
