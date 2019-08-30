<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Protected  Sub Menu1_MenuItemClick(ByVal sender As Object, ByVal e As MenuEventArgs)
        lblMessage.Text = "You selected " & Menu1.SelectedValue
    End Sub

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Menu LinkButton</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Menu
        id="Menu1"
        OnMenuItemClick="Menu1_MenuItemClick"
        Runat="server">
        <Items>
            <asp:MenuItem 
                Text="Products Page"
                Value="Products" />
            <asp:MenuItem
                Text="Services Page"
                Value="Services">
                <asp:MenuItem
                    Text="Training Page"
                    Value="Training" />
                <asp:MenuItem
                    Text="Consulting Page"
                    Value="Consulting" />    
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
