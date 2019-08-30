<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub btnConfirm_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim user As MembershipUser = Membership.GetUser(txtUserName.Text)
        If IsNothing(user) Then
            lblError.Text = "Invalid User Name"
        Else
            Dim providerCode As String = user.ProviderUserKey.ToString()
            Dim userCode As String = txtConfirmationCode.Text.Trim()
            If providerCode <> userCode Then
                lblError.Text = "Invalid Confirmation Code"
            Else
                user.IsApproved = True
                Membership.UpdateUser(user)
                Response.Redirect("~/SecretFiles/Secret.aspx")
            End If
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Confirm Code</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <p>
    Enter the confirmation code that you received by email.
    </p>
    
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
        id="lblConfirmationCode"
        Text="Confirmation Code:"
        AssociatedControlID="txtConfirmationCode"
        Runat="server" />
    <br />    
    <asp:TextBox
        id="txtConfirmationCode"
        Columns="50"
        Runat="server" />    
    <asp:Button
        id="btnConfirm"
        Text="Confirm"
        OnClick="btnConfirm_Click" 
        Runat="server" />
    
    
    </div>
    </form>
</body>
</html>
