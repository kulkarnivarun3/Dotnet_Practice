<%@ Page Language="VB" %>
<%@ Register TagPrefix="custom" Namespace="AspNetUnleashed.Samples" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Movie DataSource</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Runat="server" />
    
    <custom:MovieDataSource
        id="srcMovies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
