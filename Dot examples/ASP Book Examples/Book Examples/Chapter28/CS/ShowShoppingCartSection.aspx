<%@ Page Language="C#" Debug="true" %>
<%@ Import Namespace="AspNetUnleashed" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        ShoppingCartSection cart = (ShoppingCartSection)WebConfigurationManager.GetWebApplicationSection("system.web/shoppingCart");
        lblProvider.Text = cart.Providers[cart.DefaultProvider].Type;
    }
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
