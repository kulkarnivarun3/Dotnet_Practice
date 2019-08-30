<%@ Page Language="VB" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Sub Page_Load()
        Product1.Name = "Laptop Computer"
        Product1.Price = 1254.12
        Product1.DataBind()
    End Sub
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Product</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <custom:Product
        id="Product1"
        Runat="Server">
        <ItemTemplate>
        Name: <%# Eval("Name") %>
        <br />
        Price: <%# Eval("Price", "{0:c}") %> 
        </ItemTemplate>    
    </custom:Product>
    
    </div>
    </form>
</body>
</html>
