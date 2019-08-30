<%@ Page Language="C#" %>
<%@ OutputCache Duration="9999" VaryByParam="none" SqlDependency="CommandNotification" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Push SQL Output Cache</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <%= DateTime.Now.ToString("T") %>
    <hr />
         
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:MyMovies %>"
        SelectCommand="SELECT Title, Director FROM dbo.Movies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
