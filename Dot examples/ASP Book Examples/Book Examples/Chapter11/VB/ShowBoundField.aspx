<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show BoundField</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        AutoGenerateColumns="false"
        Runat="server">
        <Columns>
        <asp:BoundField
            DataField="Title"
            HeaderText="Movie Title" />
        <asp:BoundField
            DataField="Director"
            HeaderText="Movie Director" />
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
