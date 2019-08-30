<%@ Page Language="VB" %>
<%@ Import Namespace="AspNetUnleashed" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    sub Page_Load()
        Dim cart As ShoppingCartSection = CType(WebConfigurationManager.GetWebApplicationSection("system.web/shoppingCart"), ShoppingCartSection)
        lblProvider.Text = cart.Providers(cart.DefaultProvider).Type
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show ShoppingCartSection</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    ShoppingCart Provider Type:
    <asp:Label
        id="lblProvider"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
