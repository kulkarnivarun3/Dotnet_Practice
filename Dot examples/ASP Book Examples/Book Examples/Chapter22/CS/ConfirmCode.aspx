<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser(txtUserName.Text);
        if (user == null)
        {
            lblError.Text = "Invalid User Name";
        }
        else
        {
            string providerCode = user.ProviderUserKey.ToString();
            string userCode = txtConfirmationCode.Text.Trim();
            if (providerCode != userCode)
            {
                lblError.Text = "Invalid Confirmation Code";
            }
            else
            {
                user.IsApproved = true;
                Membership.UpdateUser(user);
                Response.Redirect("~/SecretFiles/Secret.aspx");
            }
        }
    }
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
