<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .gridView
        {
            margin:0px auto;
            border:solid 4px black;
            background-color:white;
        }
        .gridView td, .gridView th
        {
            padding:20px;
        }
        html
        {
            background-color:silver;
            font-family:Georgia, Serif;
        }
    </style>
    <title>Show Movie Count</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        CssClass="gridView"
        Runat="server" />
        
    <asp:SqlDataSource
        id="srcMovies"
        SelectCommand="CountMoviesInCategory"
        SelectCommandType="StoredProcedure"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
