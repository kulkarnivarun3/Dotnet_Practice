<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void menuTabs_MenuItemClick(object sender, MenuEventArgs e)
    {
        multiTabs.ActiveViewIndex = Int32.Parse(menuTabs.SelectedValue);
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            background-color:silver;
        }
        .menuTabs
        {
            position:relative;
            top:1px;
            left:10px;
        }
        .tab
        {
            border:Solid 1px black;
            border-bottom:none;
            padding:0px 10px;
            background-color:#eeeeee;
        }
        .selectedTab
        {
            border:Solid 1px black;
            border-bottom:Solid 1px white;
            padding:0px 10px;
            background-color:white;
        }
        .tabBody
        {
            border:Solid 1px black;
            padding:20px;
            background-color:white;
        }
    </style>
    <title>Menu Tab Strip</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Menu
        id="menuTabs"
        CssClass="menuTabs"
        StaticMenuItemStyle-CssClass="tab"
        StaticSelectedStyle-CssClass="selectedTab"
        Orientation="Horizontal"
        OnMenuItemClick="menuTabs_MenuItemClick"
        Runat="server">
        <Items>
        <asp:MenuItem
            Text="Tab 1"
            Value="0" 
            Selected="true" />
        <asp:MenuItem
            Text="Tab 2" 
            Value="1"/>
        <asp:MenuItem
            Text="Tab 3"
            Value="2" />
            
        </Items>
    </asp:Menu>    
    
    
    <div class="tabBody">
    <asp:MultiView
        id="multiTabs"
        ActiveViewIndex="0"
        Runat="server">
        <asp:View ID="view1" runat="server">
        
        Contents of first tab
        
        </asp:View>
        <asp:View ID="view2" runat="server">
        
        Contents of second tab
        
        </asp:View>
        <asp:View ID="view3" runat="server">
        
        Contents of third tab
        
        </asp:View>
    </asp:MultiView>    
    </div>
    
    </div>
    </form>
</body>
</html>
