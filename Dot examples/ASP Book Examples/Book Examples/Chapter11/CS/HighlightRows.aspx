<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void grdMovies_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            decimal boxOfficeTotals = (decimal)DataBinder.Eval(e.Row.DataItem, "BoxOfficeTotals");
            if (boxOfficeTotals > 300000000)
                e.Row.BackColor = System.Drawing.Color.Yellow;
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Highlight Rows</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        OnRowDataBound="grdMovies_RowDataBound" 
        AutoGenerateColumns="false"
        Runat="server">
        <Columns>
        <asp:BoundField
            DataField="Title"
            HeaderText="Title" />
        <asp:BoundField
            DataField="BoxOfficeTotals"
            DataFormatString="{0:c}"
            HtmlEncode="false"
            HeaderText="Box Office Totals" />
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
