<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<script runat="server">

    protected void grdMovies_DataBound(object sender, EventArgs e)
    {
        Menu menuPager = (Menu)grdMovies.BottomPagerRow.FindControl("menuPager");
        for (int i = 0; i < grdMovies.PageCount; i++)
        {
            MenuItem item = new MenuItem();
            item.Text = String.Format("[{0}]",i + 1);
            item.Value = i.ToString();
            if (grdMovies.PageIndex == i)
                item.Selected = true;
            menuPager.Items.Add(item);
        }    
    }

    protected void menuPager_MenuItemClick(object sender, MenuEventArgs e)
    {
        grdMovies.PageIndex = Int32.Parse(e.Item.Value);
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .menu td
        {
            padding:5px 0px;
        }
        .selectedPage a
        {
            font-weight:bold;
            color:red;
        }
    </style>
    <title>Page Template Grid</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        AllowPaging="true"
        PageSize="3"
        Runat="server" OnDataBound="grdMovies_DataBound">
        <PagerTemplate>
        <table>
        <tr><td>
        <asp:LinkButton
            id="lnkPrevious"
            Text="&lt; Prev"
            CommandName="Page"
            CommandArgument="Prev"
            ToolTip="Previous Page"
            Runat="server" /> 
        </td><td>
        <asp:Menu
            id="menuPager"
            Orientation="Horizontal"
            OnMenuItemClick="menuPager_MenuItemClick"
            StaticSelectedStyle-CssClass="selectedPage"
            CssClass="menu" 
            Runat="server" />
        </td><td>
        <asp:LinkButton
            id="lnkNext"
            Text="Next &gt;"
            CommandName="Page"
            CommandArgument="Next"
            ToolTip="Next Page"
            Runat="server" />
        </td></tr>
        </table>    
        </PagerTemplate>
    </asp:GridView>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director FROM Movies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
