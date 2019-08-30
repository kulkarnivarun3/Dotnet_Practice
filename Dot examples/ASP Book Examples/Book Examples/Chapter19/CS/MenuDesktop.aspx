<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .staticMenuItem
        {
            color:black;
            border:solid 1px black;
            padding:2px 4px;
        }
        .menuHover
        {
            color:white;
            background-color:blue;
        }
        .dynamicMenuItem
        {
            color:black;
            padding:2px 4px;       
        }
        .dynamicMenu
        {
            border:Solid 1px black;
            filter:progid:DXImageTransform.Microsoft.dropshadow(OffX=5, OffY=5, Color='gray', Positive='true')" 
        }
    </style>
    <title>Menu Desktop</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Menu
        id="Menu1"
        Orientation="Horizontal"
        StaticMenuItemStyle-CssClass="staticMenuItem"
        StaticHoverStyle-CssClass="menuHover"
        DynamicHoverStyle-CssClass="menuHover"
        DynamicMenuItemStyle-CssClass="dynamicMenuItem"
        DynamicMenuStyle-CssClass="dynamicMenu"
        Runat="server">
        <Items>
        <asp:MenuItem 
            Text="File"
            Selectable="false">
            <asp:MenuItem 
                Text="Save" />
            <asp:MenuItem 
                Text="Open" />
        </asp:MenuItem>    
        <asp:MenuItem 
            Text="Format"
            Selectable="false">
            <asp:MenuItem 
                Text="Bold" 
                ImageUrl="Images/Bold.gif" />
            <asp:MenuItem 
                Text="Italic" 
                ImageUrl="Images/Italic.gif" />
            <asp:MenuItem 
                Text="Underline"
                ImageUrl="Images/Underline.gif"
                SeparatorImageUrl="Images/Divider.gif" />
            <asp:MenuItem
                Text="Left Align" 
                ImageUrl="Images/JustifyLeft.gif" />
            <asp:MenuItem
                Text="Center Align" 
                ImageUrl="Images/JustifyCenter.gif" />            
            <asp:MenuItem
                Text="Right Align"
                ImageUrl="Images/JustifyRight.gif" />                
        </asp:MenuItem>    
        </Items>
    </asp:Menu>    
    
    </div>
    </form>
</body>
</html>
