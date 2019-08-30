<%@ Page Language="VB" Trace="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Show Cached Movies</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Runat="server" />
    
    <asp:ObjectDataSource
        id="srcMovies"
        TypeName="Movie"
        SelectMethod="SelectCached"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
