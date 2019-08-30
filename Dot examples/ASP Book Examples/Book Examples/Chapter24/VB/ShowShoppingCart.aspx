<%@ Page Language="VB" %>
<%@ Import Namespace="AspNetUnleashed" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Private Sub Page_PreRender()
        grdShoppingCart.DataSource = Profile.ShoppingCart.Items
        grdShoppingCart.DataBind()
    End Sub
 
    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim NewItem As New CartItem(txtName.Text, Decimal.Parse(txtPrice.Text), txtDescription.Text)
        Profile.ShoppingCart.Items.Add(NewItem)
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show ShoppingCart</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdShoppingCart"
        EmptyDataText="There are no items in your shopping cart"
        Runat="server" />
    
    <br />
    
    <fieldset>
    <legend>Add Product</legend>    
    <asp:Label
        id="lblName"
        Text="Name:"
        AssociatedControlID="txtName"
        Runat="server" />
    <br />
    <asp:TextBox
        id="txtName"
        Runat="server" />
    <br /><br />
    <asp:Label
        id="lblPrice"
        Text="Price:"
        AssociatedControlID="txtPrice"
        Runat="server" />
    <br />
    <asp:TextBox
        id="txtPrice"
        Runat="server" />
    <br /><br />
    <asp:Label
        id="lblDescription"
        Text="Description:"
        AssociatedControlID="txtDescription"
        Runat="server" />
    <br />
    <asp:TextBox
        id="txtDescription"
        Runat="server" />
    <br /><br />    
    <asp:Button 
        id="btnAdd"
        Text="Add To Cart"
        Runat="server" OnClick="btnAdd_Click" />        
    </fieldset>
    
    </div>
    </form>
</body>
</html>
