<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>ChangePassword Template</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:ChangePassword
        id="ChangePassword1"
        DisplayUserName="true"
        Runat="server">
        <ChangePasswordTemplate>
            <h1>Change Password</h1>
            <asp:Label
                id="FailureText"
                EnableViewState="false"
                ForeColor="Red"
                Runat="server" />
            <br />
            <asp:Label
                id="lblUserName"
                Text="User Name:"
                AssociatedControlID="UserName"
                Runat="server" />
            <br />
            <asp:TextBox
                id="UserName"
                Runat="server" />
            <br /><br />
            <asp:Label
                id="lblCurrentPassword"
                Text="Current Password:"
                AssociatedControlID="CurrentPassword"
                Runat="server" />
            <br />
            <asp:TextBox
                id="CurrentPassword"
                TextMode="Password"
                Runat="server" />
            <br /><br />
            <asp:Label
                id="lblNewPassword"
                Text="New Password:"
                AssociatedControlID="NewPassword"
                Runat="server" />
            <br />
            <asp:TextBox
                id="NewPassword"
                TextMode="Password"
                Runat="server" />
            <br /><br />
            <asp:Button
                id="btnChangePassword"
                Text="Change Password"
                CommandName="ChangePassword"
                Runat="server" />        
        </ChangePasswordTemplate>
        <SuccessTemplate>
            Your password has been changed!
        </SuccessTemplate>    
    </asp:ChangePassword>
    
    </div>
    </form>
</body>
</html>
