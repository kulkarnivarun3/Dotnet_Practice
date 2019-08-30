<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Home</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:SiteMapPath
        id="SiteMapPath1"
        Runat="server" />
    
    <hr />
    
    <asp:TreeView
        id="TreeView1"
        DataSourceID="srcSiteMap"
        Runat="server" />
        
    <asp:SiteMapDataSource
        id="srcSiteMap"
        Runat="server" />    
    
    </div>
    </form>
</body>
</html>
