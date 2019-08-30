<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    decimal totals;

    protected void dlstMovies_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.DataItem != null)
            totals += (decimal)DataBinder.Eval(e.Item.DataItem, "BoxOfficeTotals");
        if (e.Item.ItemType == ListItemType.Footer)
        {
            Label lblTotal = (Label)e.Item.FindControl("lblTotal");
            lblTotal.Text = totals.ToString("c");
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
    .movies td
    {
        padding:10px;
        text-align:right;
    }
    </style>
    <title>Show DataList Templates</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DataList
        id="dlstMovies"
        DataSourceID="srcMovies"
        GridLines="Horizontal"
        UseAccessibleHeader="true"
        OnItemDataBound="dlstMovies_ItemDataBound"
        CssClass="movies"
        Runat="server" >
        <HeaderTemplate>
        Movie Box Office Totals
        </HeaderTemplate>
        <ItemTemplate>
        <%#Eval("Title")%>:
        <%#Eval("BoxOfficeTotals","{0:c}") %>
        </ItemTemplate>
        <FooterTemplate>
        <b>Total:</b>
        <asp:Label
            id="lblTotal"
            Runat="server" />
        </FooterTemplate>
    </asp:DataList>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Title,BoxOfficeTotals
            FROM Movies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
