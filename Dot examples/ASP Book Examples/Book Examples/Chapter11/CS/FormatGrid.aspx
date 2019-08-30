<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .grid
        {
            font:16px Arial, Sans-Serif;
        }
        .grid td, .grid th
        {
            padding:10px;
        }
        .header
        {
            text-align:left;
            color:white;
            background-color:blue;
        }
        .row td
        {
            border-bottom:solid 1px blue;
        }
        .alternating
        {
            background-color:#eeeeee;
        }
        .alternating td
        {
            border-bottom:solid 1px blue;
        }
    </style>
    <title>Format Grid</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        GridLines="None"
        CssClass="grid"
        HeaderStyle-CssClass="header"
        RowStyle-CssClass="row"
        AlternatingRowStyle-CssClass="alternating"
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
