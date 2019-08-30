<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Protected Sub grdMovies_DataBound(ByVal sender As Object, ByVal e As EventArgs)
        Dim menuPager As Menu = CType(grdMovies.BottomPagerRow.FindControl("menuPager"), Menu)
        For i As Integer = 0 To grdMovies.PageCount - 1
            Dim item As New MenuItem()
            item.Text = String.Format("[{0}]", i + 1)
            item.Value = i.ToString()
            If grdMovies.PageIndex = i Then
                item.Selected = True
            End If
            menuPager.Items.Add(item)
        Next
    End Sub
 
    Protected  Sub menuPager_MenuItemClick(ByVal sender As Object, ByVal e As MenuEventArgs)
        grdMovies.PageIndex = Int32.Parse(e.Item.Value)
    End Sub
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
