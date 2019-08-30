<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .menuLevel1
        {
            font:40px Arial,Sans-Serif;
        }
        .menuLevel2
        {
            font:20px Arial,Sans-Serif;
        }        
        .menuLevel3
        {
            font:10px Arial,Sans-Serif;
        }
    </style>
    <title>Menu Level Styles</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Menu
        id="Menu1"
        Runat="server">
        <LevelMenuItemStyles>
            <asp:MenuItemStyle CssClass="menuLevel1" />
            <asp:MenuItemStyle CssClass="menuLevel2" />
            <asp:MenuItemStyle CssClass="menuLevel3" />
        </LevelMenuItemStyles>
        <Items>
        <asp:MenuItem Text="Produce">
            <asp:MenuItem Text="Apples" />
            <asp:MenuItem Text="Oranges" />
        </asp:MenuItem>
        <asp:MenuItem Text="Beverages">
            <asp:MenuItem Text="Soda">
                <asp:MenuItem Text="Coke" />
                <asp:MenuItem Text="Pepsi" />
            </asp:MenuItem>
        </asp:MenuItem>
        </Items>
    </asp:Menu>    
        
    </div>
    </form>
</body>
</html>
