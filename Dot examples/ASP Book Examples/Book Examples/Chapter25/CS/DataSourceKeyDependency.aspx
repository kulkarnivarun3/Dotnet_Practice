<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void srcMovies_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        lblMessage.Text = "Selecting data from database";
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>DataSource Key Dependency</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <p>
    <asp:Label
        id="lblMessage"
        EnableViewState="false"
        Runat="server" />
    </p>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Runat="server" />
        
    <asp:SqlDataSource
        id="srcMovies"
        EnableCaching="True"
        CacheDuration="Infinite"
        CacheKeyDependency="MovieKey"
        SelectCommand="SELECT * FROM Movies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        OnSelecting="srcMovies_Selecting"
        Runat="server" />
        
    <br /><br />
    <a href="AddMovieDataSourceKeyDependency.aspx">Add Movie</a>

    </div>
    </form>
</body>
</html>
