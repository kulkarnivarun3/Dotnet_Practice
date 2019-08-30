<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            background-color:silver;
        }
        .navigation
        {
            float:left;
            width:280px;
            height:500px;
            padding:20px;
            background-color:#eeeeee;
        }
        .content
        {
            float:left;
            width:550px;
            height:500px;
            padding:20px;
            background-color:white;
        }
        .menuItem
        {
            border:Outset 1px black;
            background-color:Gray;
            font:14px Arial;
            color:White;
            padding:8px;
        }
    </style>
    <title>Menu Navigate</title>
</head>
<body>
    <form id="form1" runat="server">


    <div class="navigation">
    
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

    <div class="content">
        
    <h1>Displaying a Website menu with the Menu control</h1>
    
    </div>


    </form>
</body>
</html>
