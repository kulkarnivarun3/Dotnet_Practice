<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:TextBox
        id="txtLogin"
        Runat="server" />
    <asp:RequiredFieldValidator
        id="valLogin"
        ControlToValidate="txtLogin"
        Text="Required"
        ValidationGroup="Login"
        Runat="server" />    
        
        
    <asp:Button
        id="btnLogin"
        Text="Login"
        ValidationGroup="Login"
        Runat="server" />    
        
    <hr />
    
        
    <asp:TextBox
        id="txtRegister"
        Runat="server" />
    <asp:RequiredFieldValidator
        id="RequiredFieldValidator1"
        ControlToValidate="txtRegister"
        Text="Required"
        Runat="server" />    

    <asp:Button
        id="btnRegister"
        Text="Register"
        Runat="server" />    

    
        
    
    
    
    
    </div>
    </form>
</body>
</html>
