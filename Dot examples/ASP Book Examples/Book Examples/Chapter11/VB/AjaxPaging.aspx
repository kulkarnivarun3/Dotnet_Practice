<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>AJAX Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:ScriptManager ID="sm1" runat="server" />
    
    <%= DateTime.Now.ToString("T") %>
    
    <asp:UpdatePanel ID="up1" runat="server">    
    <ContentTemplate>

    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        AllowPaging="true"
        PageSize="3"
        Runat="server" />

    </ContentTemplate>
    </asp:UpdatePanel>

    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director FROM Movies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
