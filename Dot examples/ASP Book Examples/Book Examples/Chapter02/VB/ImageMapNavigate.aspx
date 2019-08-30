<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>ImageMap Navigate</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:ImageMap
        id="mapNavigate"
        ImageUrl="ImageBar.jpg"
        Runat="server">
        <asp:RectangleHotSpot
            NavigateUrl="Home.aspx" 
            Left="0"
            Top="0"
            Right="100"
            Bottom="50" 
            AlternateText="Navigate to Home" />
        <asp:RectangleHotSpot
            NavigateUrl="Products.aspx" 
            Left="100"
            Top="0"
            Right="200"
            Bottom="50" 
            AlternateText="Navigate to Products" />
        <asp:RectangleHotSpot
            NavigateUrl="Services.aspx" 
            Left="200"
            Top="0"
            Right="300"
            Bottom="50" 
            AlternateText="Navigate to Services" />
    </asp:ImageMap>
    
    </div>
    </form>
</body>
</html>
