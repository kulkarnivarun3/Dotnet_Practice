<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Page.IsValid Then
            lblResult.Text = "<br />Product: " & txtProductName.Text
            lblResult.Text &= "<br />Price: " & txtProductPrice.Text
            lblResult.Text &= "<br />Quantity: " & txtProductQuantity.Text
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Order Form</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <fieldset>
    <legend>Product Order Form</legend>
    
    <asp:Label
        id="lblProductName"
        Text="Product Name:"
        AssociatedControlID="txtProductName"
        Runat="server" />
    <br />
    <asp:TextBox
        id="txtProductName"
        Runat="server" />
    <asp:RequiredFieldValidator
        id="reqProductName"
        ControlToValidate="txtProductName"
        Text="(Required)"
        Runat="server" />
        
    <br /><br />
        
    <asp:Label
        id="lblProductPrice"
        Text="Product Price:"
        AssociatedControlID="txtProductPrice"
        Runat="server" />
    <br />    
    <asp:TextBox
        id="txtProductPrice"
        Columns="5"
        Runat="server" />    
    <asp:RequiredFieldValidator
        id="reqProductPrice"
        ControlToValidate="txtProductPrice"
        Text="(Required)"
        Display="Dynamic"
        Runat="server" />
    <asp:CompareValidator
        id="cmpProductPrice"
        ControlToValidate="txtProductPrice"
        Text="(Invalid Price)"
        Operator="DataTypeCheck"
        Type="Currency"
        Runat="server" />

    <br /><br />

    <asp:Label
        id="lblProductQuantity"
        Text="Product Quantity:"
        AssociatedControlID="txtProductQuantity"
        Runat="server" />
    <br />        
    <asp:TextBox
        id="txtProductQuantity"
        Columns="5"
        Runat="server" />    
    <asp:RequiredFieldValidator
        id="reqProductQuantity"
        ControlToValidate="txtProductQuantity"
        Text="(Required)"
        Display="Dynamic"
        Runat="server" />
    <asp:CompareValidator
        id="CompareValidator1"
        ControlToValidate="txtProductQuantity"
        Text="(Invalid Quantity)"
        Operator="DataTypeCheck"
        Type="Integer"
        Runat="server" />

    <br /><br />
    
    <asp:Button
        id="btnSubmit"
        Text="Submit Product Order"
        OnClick="btnSubmit_Click" 
        Runat="server" />
    
    </fieldset>

    <asp:Label
        id="lblResult"
        Runat="server" />

    </div>
    </form>
</body>
</html>
