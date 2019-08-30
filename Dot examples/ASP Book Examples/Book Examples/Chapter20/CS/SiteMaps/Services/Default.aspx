<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .menuItem
        {
            border:solid 1px black;
            background-color:#eeeeee;
            padding:4px;
            margin:1px 0px;
        }
    </style>
    <title>Our Services</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:SiteMapPath
        id="SiteMapPath1"
        Runat="server" />
    
    <hr />
    
    <asp:Menu
        id="Menu1"
        DataSourceID="srcSiteMap"
        StaticMenuItemStyle-CssClass="menuItem"
        DynamicMenuItemStyle-CssClass="menuItem"
        Runat="server" />
        
    <asp:SiteMapDataSource
        id="srcSiteMap"
        ShowStartingNode="false"
        Runat="server" />    
    
    </div>
    </form>
</body>
</html>
