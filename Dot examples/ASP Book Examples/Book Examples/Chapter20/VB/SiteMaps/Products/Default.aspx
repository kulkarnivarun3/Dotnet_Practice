<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            font:16px Georgia,Serif;
        }
        .productList li
        {
            margin:5px;
        }
    </style>
    <title>Our Products</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <h1>Products</h1>
    
    <asp:BulletedList
        id="bltProducts"
        DisplayMode="HyperLink"
        DataTextField="Title"
        DataValueField="Url"
        DataSourceID="srcSiteMap"
        CssClass="productList"
        Runat="server" />
        
        
    <asp:SiteMapDataSource
        id="srcSiteMap"
        ShowStartingNode="false"
        StartFromCurrentNode="true"
        Runat="server" />    
    
    
    </div>
    </form>
</body>
</html>
