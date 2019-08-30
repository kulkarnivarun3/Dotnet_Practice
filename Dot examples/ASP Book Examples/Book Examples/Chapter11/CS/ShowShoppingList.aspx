<%@ Page Language="C#" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    void Page_Load()
    {
        // Build shopping list
        List<string> shoppingList = new List<string>();
        shoppingList.Add("Bread");
        shoppingList.Add("Milk");
        shoppingList.Add("Beer");
        shoppingList.Add("Waffles");
        
        // Bind to GridView
        grdShoppingList.DataSource = shoppingList;
        grdShoppingList.DataBind();
    }
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Shopping List</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdShoppingList"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
