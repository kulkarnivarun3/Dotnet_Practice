<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Protected Sub grdMovies_RowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim boxOfficeTotals As Decimal = CType(DataBinder.Eval(e.Row.DataItem, "BoxOfficeTotals"), Decimal)
            If boxOfficeTotals > 300000000 Then
                e.Row.BackColor = System.Drawing.Color.Yellow
            End If
        End If
    End Sub
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
