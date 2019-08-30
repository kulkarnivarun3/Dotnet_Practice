<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void btnSort_Click(object sender, EventArgs e)
    {
        grdMovies.Sort(ddlSort.Text, SortDirection.Ascending);
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Custom Sorting</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:DropDownList
        id="ddlSort"
        Runat="server">
        <asp:ListItem Text="Id" />
        <asp:ListItem Text="Title" />
        <asp:ListItem Text="Director" />
    </asp:DropDownList>
    <asp:Button
        id="btnSort"
        Text="Sort"
        Runat="server" OnClick="btnSort_Click" />
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Runat="server" />     
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director FROM Movies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
