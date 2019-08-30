<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Menu1_MenuItemClick(ByVal sender As Object, ByVal e As MenuEventArgs)
        Dim index As Integer = Int32.Parse(e.Item.Value)
        MultiView1.ActiveViewIndex = index
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            background-color:silver;
        }
        .tabs
        {
            position:relative;
            top:1px;
            left:10px;
        }
        .tab
        {
            border:solid 1px black;
            background-color:#eeeeee;
            padding:2px 10px;
        }
        .selectedTab
        {
            background-color:white;
            border-bottom:solid 1px white;
        }
        .tabContents
        {
            border:solid 1px black;
            padding:10px;
            background-color:white;
        }
    </style>
    <title>MultiView Tabs</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Menu
        id="Menu1"
        Orientation="Horizontal"
        StaticMenuItemStyle-CssClass="tab"
        StaticSelectedStyle-CssClass="selectedTab"
        CssClass="tabs"
        OnMenuItemClick="Menu1_MenuItemClick"
        Runat="server">
        <Items>
        <asp:MenuItem Text="Tab 1" Value="0" Selected="true" />
        <asp:MenuItem Text="Tab 2" Value="1" />
        <asp:MenuItem Text="Tab 3" Value="2" />
        </Items>    
    </asp:Menu>
    
    <div class="tabContents">
    <asp:MultiView
        id="MultiView1"
        ActiveViewIndex="0"
        Runat="server">
        <asp:View ID="View1" runat="server">
            <br />This is the first view
            <br />This is the first view
            <br />This is the first view
            <br />This is the first view
        </asp:View>        
        <asp:View ID="View2" runat="server">
            <br />This is the second view
            <br />This is the second view
            <br />This is the second view
            <br />This is the second view
        </asp:View>        
        <asp:View ID="View3" runat="server">
            <br />This is the third view
            <br />This is the third view
            <br />This is the third view
            <br />This is the third view
        </asp:View>        
    </asp:MultiView>
    </div>
    
    </div>
    </form>
</body>
</html>
