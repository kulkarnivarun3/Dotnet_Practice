<%@ Page Language="VB" %>
<%@ Register TagPrefix="custom" Namespace="AspNetUnleashed" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    Sub Menu1_MenuItemClick(sender As Object, e As MenuEventArgs)
        lblSelected.Text = Menu1.SelectedValue
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .menu
        {
            border:solid 1px black;
            padding:4px;
        }
    </style>
    <title>Show Menu</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Menu
        id="Menu1"
        DataSourceId="srcCategories"
        OnMenuItemClick="Menu1_MenuItemClick"
        Orientation="Horizontal"
        DynamicMenuStyle-CssClass="menu"
        Runat="server">
        <DataBindings>
            <asp:MenuItemBinding TextField="Name" ValueField="Name" />
        </DataBindings>
    </asp:Menu>    
     
    <custom:SqlHierarchicalDataSource
        id="srcCategories"
        ConnectionString='<%$ ConnectionStrings:Categories %>'
        DataKeyName="CategoryId"
        DataParentKeyName="ParentId"
        SelectCommand="SELECT CategoryId, ParentId, Name FROM Categories"
        Runat="server" />
    
    <hr />
    
    <asp:Label
        id="lblSelected"
        Runat="server" />    
    
    </div>
    </form>
</body>
</html>
