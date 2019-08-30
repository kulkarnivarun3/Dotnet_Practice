<%@ Page Language="VB" %>
<%@ OutputCache Duration="3600" VaryByParam="none" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        Cache.Insert("Movies", DateTime.Now)
        Response.AddCacheItemDependency("Movies")
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Movie List Key Dependency</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <%= DateTime.Now.ToString("T") %>
    <hr />
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Title, Director FROM Movies"
        Runat="server" />
   
   <br /><br />
   <a href="AddMovieKeyDependency.aspx">Add Movie</a>
   
    </div>
    </form>
</body>
</html>
