<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void srcMovies_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        lblMessage.Text = "Retrieving data from database";
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Cache SqlDataSource</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblMessage"
        EnableViewState="false"
        Runat="server" />
    <br /><br />
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Runat="server" />
        
    <asp:SqlDataSource
        id="srcMovies"
        EnableCaching="True"
        CacheDuration="3600"
        SelectCommand="SELECT * FROM Movies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        Runat="server" OnSelecting="srcMovies_Selecting" />
    
    </div>
    </form>
</body>
</html>
