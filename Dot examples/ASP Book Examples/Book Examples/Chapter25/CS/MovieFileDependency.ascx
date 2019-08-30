<%@ Control Language="C#" ClassName="MovieFileDependency" %>
<%@ OutputCache Duration="9999" VaryByParam="none" %>
<script runat="server">

    void Page_Load()
    {
        CacheDependency depend = new CacheDependency(MapPath("~/Movies.xml"));
        this.CachePolicy.Dependency = depend;
    }
</script>
User Control Time:    
<%= DateTime.Now.ToString("T") %>
<hr />

<asp:GridView
    id="grdMovies"
    DataSourceID="srcMovies"
    Runat="server" />

<asp:XmlDataSource
    id="srcMovies"
    DataFile="Movies.xml"
    Runat="server" />


