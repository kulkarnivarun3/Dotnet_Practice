<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .loginError
        {
            color:red;
            font:bold 14px Arial,Sans-Serif;
        }
    </style>
    <title>Login Template</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Login
        id="Login1"
        Runat="server">
        <LayoutTemplate>
        <asp:Label
            id="FailureText"
            EnableViewState="false"
            CssClass="loginError"
            Runat="server" />
        
        <br />    
        <asp:Label
            id="lblUserName"
            AssociatedControlID="UserName"
            Text="Username:"
            Runat="server" />
        <br />
        <asp:TextBox
            id="UserName"
            Runat="server" />    
        
        <br /><br />
        <asp:Label
            id="lblPassword"
            AssociatedControlID="Password"
            Text="Password:"
            Runat="server" />
        <br />
        <asp:TextBox
            id="Password"
            TextMode="Password"
            Runat="server" />    
        
        <br /><br />
        <asp:Button
            id="btnLogin"
            Text="Login"
            CommandName="Login"
            Runat="server" />
        </LayoutTemplate>    
    </asp:Login>
    
    </div>
    </form>
</body>
</html>
