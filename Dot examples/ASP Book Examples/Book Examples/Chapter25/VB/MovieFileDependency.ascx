<%@ Control Language="VB" ClassName="MovieFileDependency" %>
<%@ OutputCache Duration="9999" VaryByParam="none" %>
<script runat="server">

    Sub Page_Load()
        Dim depend As New CacheDependency(MapPath("~/Movies.xml"))
        Me.CachePolicy.Dependency = depend
    End Sub
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


