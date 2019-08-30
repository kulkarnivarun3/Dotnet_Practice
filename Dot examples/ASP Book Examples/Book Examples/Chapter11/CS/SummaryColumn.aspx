<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    private decimal _boxOfficeTotalsTotal = 0;

    protected void grdMovies_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            decimal boxOfficeTotals = (decimal)DataBinder.Eval(e.Row.DataItem, "BoxOfficeTotals");
            _boxOfficeTotalsTotal += boxOfficeTotals;
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblSummary = (Label)e.Row.FindControl("lblSummary");
            lblSummary.Text = String.Format("Total: {0:c}", _boxOfficeTotalsTotal);
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Summary Column</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        OnRowDataBound="grdMovies_RowDataBound" 
        AutoGenerateColumns="false"
        ShowFooter="true"
        Runat="server">
        <Columns>
        <asp:BoundField
            DataField="Title"
            HeaderText="Title" />
        <asp:TemplateField HeaderText="Box Office Totals">
        <ItemTemplate>
            <%# Eval("BoxOfficeTotals", "{0:c}") %>
        </ItemTemplate>
        <FooterTemplate>
            <asp:Label
                id="lblSummary"
                Runat="server" />
        </FooterTemplate>
        </asp:TemplateField>    
        </Columns>
    </asp:GridView>
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT * FROM Movies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
