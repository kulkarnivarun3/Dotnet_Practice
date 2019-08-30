<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
    {
        lblMessage.Text = Menu1.SelectedValue;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .menuItem
        {
            color:black;
            border:Solid 1px Gray;
            background-color:#c9c9c9;
            padding:2px 5px;
        }
    </style>
    <title>Menu Templates</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Menu
        id="Menu1"
        OnMenuItemClick="Menu1_MenuItemClick"
        Orientation="Horizontal"
        StaticMenuItemStyle-CssClass="menuItem"
        DynamicMenuItemStyle-CssClass="menuItem"
        Runat="server">
        <StaticItemTemplate>
        <%# Eval("Text") %>
        (<%# Eval("ChildItems.Count") %>)
        </StaticItemTemplate>
        <DynamicItemTemplate>
        <%# Eval("Text") %>
        (<%# Eval("ChildItems.Count") %>)
        </DynamicItemTemplate>
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
    
    <hr />
    
    <asp:Label
        id="lblMessage"
        EnableViewState="false"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
