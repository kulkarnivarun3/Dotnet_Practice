<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Details</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Title,Director FROM Movies
            WHERE CategoryId=@CategoryId"
        Runat="server">
        <SelectParameters>
        <asp:QueryStringParameter
            Name="CategoryId"
            QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>    
    
    </div>
    </form>
</body>
</html>
