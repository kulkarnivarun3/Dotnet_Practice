<%@ Page Language="VB" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Public ReadOnly Property ProductName() As String
        Get
            Return txtProductName.Text
        End Get
    End Property
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show AdvancedCheckBox</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblProductName"
        Text="Product Name:"
        AssociatedControlID="txtProductName"
        Runat="server" />
        
    <asp:TextBox
        id="txtProductName"
        Runat="server" />
            
    <br /><br />
    
    <custom:AdvancedCheckBox
        id="AdvancedCheckBox1"
        Text="Advanced Options"
        PostBackUrl="AdvancedOptions.aspx"
        Runat="server" />

    </div>
    </form>
</body>
</html>
