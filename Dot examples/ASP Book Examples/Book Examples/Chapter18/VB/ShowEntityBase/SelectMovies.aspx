<%@ Page Language="vb" Trace="true" %>
<%@ Register TagPrefix="custom" Namespace="Superexpert.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Select Movies</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceId="srcMovies"
        Runat="server" />
    
    <custom:EntityDataSource
        id="srcMovies"
        TypeName="Movie"
        Runat="Server" />
    
    </div>
    </form>
</body>
</html>
