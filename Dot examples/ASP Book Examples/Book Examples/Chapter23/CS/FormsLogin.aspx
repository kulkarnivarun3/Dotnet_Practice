<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (FormsAuthentication.Authenticate(txtUserName.Text,txtPassword.Text))
            FormsAuthentication.RedirectFromLoginPage(txtUserName.Text, chkRememberMe.Checked);
        else
            lblError.Text = "Invalid user name/password";
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Forms Login</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblError"
        EnableViewState="false"
        ForeColor="Red"
        Runat="server" />
    
    <br /><br />
    <asp:Label
        id="lblUserName"
        Text="User Name:"
        AssociatedControlID="txtUserName"
        Runat="server" />
    <br />
    <asp:TextBox
        id="txtUserName"
        Runat="server" />
    <br /><br />    
    <asp:Label
        id="lblPassword"
        Text="Password:"
        AssociatedControlID="txtPassword"
        Runat="server" />
    <br />
    <asp:TextBox
        id="txtPassword"
        TextMode="Password"
        Runat="server" />
    <br /><br />
    <asp:CheckBox
        id="chkRememberMe"
        Text="Remember Me"
        Runat="server" />
    <br /><br />
    <asp:Button
        id="btnLogin"
        Text="Login"
        OnClick="btnLogin_Click" 
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
