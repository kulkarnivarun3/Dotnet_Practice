<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Protected Sub btnLogin_Click(ByVal sender As Object, ByVal e As EventArgs)
        If Page.IsValid() Then
            lblLoginResult.Text = "Log in successful!"
        End If
    End Sub

    Protected Sub btnRegister_Click(ByVal sender As Object, ByVal e As EventArgs)
        If Page.IsValid() Then
            lblRegisterResult.Text = "Registration successful!"
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            background-color:silver;
        }
        .column
        {
            float:left;
            width:300px;
            margin-left:10px;
            background-color:white;
            border:solid 1px black;
            padding:10px;
        }
    </style>
    <title>Show Validation Groups</title>
</head>
<body>
    <form id="form1" runat="server">
    
    <div class="column">
    <fieldset>
    <legend>Login</legend>
    <p>
    Please log in to our Website.
    </p>
    <asp:Label
        id="lblUserName"
        Text="User Name:"
        AssociatedControlID="txtUserName"
        Runat="server" />
    <br />    
    <asp:TextBox
        id="txtUserName"
        Runat="server" />
    <asp:RequiredFieldValidator
        id="reqUserName"
        ControlToValidate="txtUserName"
        Text="(Required)"
        ValidationGroup="LoginGroup"
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
    <asp:RequiredFieldValidator
        id="reqPassword"
        ControlToValidate="txtPassword"
        Text="(Required)"
        ValidationGroup="LoginGroup"
        Runat="server" />
    <br /><br />
    <asp:Button
        id="btnLogin"
        Text="Login"
        ValidationGroup="LoginGroup"
        Runat="server" OnClick="btnLogin_Click" />
    </fieldset>

    <asp:Label 
        id="lblLoginResult"
        Runat="server" />

    </div>

    <div class="column">
    <fieldset>
    <legend>Register</legend>
    <p>
    If you do not have a User Name, please
    register at our Website.
    </p>
    <asp:Label
        id="lblFirstName"
        Text="First Name:"
        AssociatedControlID="txtFirstName"
        Runat="server" />
    <br />    
    <asp:TextBox
        id="txtFirstName"
        Runat="server" />
    <asp:RequiredFieldValidator
        id="reqFirstName"
        ControlToValidate="txtFirstName"
        Text="(Required)"
        ValidationGroup="RegisterGroup"
        Runat="server" />
    <br /><br />
    <asp:Label
        id="lblLastName"
        Text="Last Name:"
        AssociatedControlID="txtLastName"
        Runat="server" />
    <br />    
    <asp:TextBox
        id="txtLastName"
        Runat="server" />
    <asp:RequiredFieldValidator
        id="reqLastName"
        ControlToValidate="txtLastName"
        Text="(Required)"
        ValidationGroup="RegisterGroup"
        Runat="server" />
    <br /><br />
    <asp:Button
        id="btnRegister"
        Text="Register"
        ValidationGroup="RegisterGroup"
        Runat="server" OnClick="btnRegister_Click" />
    </fieldset>
    
    <asp:Label 
        id="lblRegisterResult"
        Runat="server" />
        
    </div>
    
    </form>
</body>
</html>
