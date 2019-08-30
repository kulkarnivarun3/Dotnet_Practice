<%@ Page Language="VB" %>
<%@ Register TagPrefix="user" TagName="AddressForm" Src="~/AddressForm.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        ' Show Billing Address Form Results
        ltlResults.Text = "<br />Billing Street: " + AddressForm1.Street
        ltlResults.Text += "<br />Billing City: " + AddressForm1.City
        ltlResults.Text += "<br />Billing State: " + AddressForm1.State
        ltlResults.Text += "<br />Billing Postal Code: " + AddressForm1.PostalCode
 
        ltlResults.Text += "<br /><br />"
 
        ' Show Shipping Address Form Results
        ltlResults.Text += "<br />Shipping Street: " + AddressForm2.Street
        ltlResults.Text += "<br />Shipping City: " + AddressForm2.City
        ltlResults.Text += "<br />Shipping State: " + AddressForm2.State
        ltlResults.Text += "<br />Shipping Postal Code: " + AddressForm2.PostalCode
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            background-color:silver;
            font:14px Georgia,Serif;
        }
        .content
        {
            background-color:white;
            width:600px;
            margin:auto;
            padding:20px;
        }
        .addressLabel
        {
            float:left;
            width:100px;
            padding:5px;
            text-align:right;
        }
        .addressField
        {
            float:left;
            padding:5px;
        }
        .clear
        {
            clear:both;
        }

    </style>
    <title>Checkout</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="content">
    
    <user:AddressForm
        id="AddressForm1"
        Title="Billing Address"
        Runat="server" />

    <br />

    <user:AddressForm
        id="AddressForm2"
        Title="Shipping Address"
        Runat="server" />

    <br />
    
    <asp:Button
        ID="btnSubmit"
        Text="Submit Form"
        OnClick="btnSubmit_Click" 
        Runat="server" />

    <hr />

    <asp:Literal
        id="ltlResults"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
