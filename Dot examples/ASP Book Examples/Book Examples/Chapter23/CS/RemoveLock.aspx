<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void btnRemove_Click(object sender, EventArgs e)
    {
        MembershipUser userToUnlock = Membership.GetUser(txtUserName.Text);
        if (userToUnlock == null)
        {
            lblMessage.Text = "User not found!";
        }
        else
        {
            userToUnlock.UnlockUser();
            lblMessage.Text = "Lock removed!";
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Remove Lock</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblUserName"
        Text="User Name:"
        AssociatedControlID="txtUserName"
        Runat="server" />
    <asp:TextBox
        id="txtUserName"
        Runat="server" />
    <asp:Button
        id="btnRemove"
        Text="Remove Lock"
        Runat="server" OnClick="btnRemove_Click" />
    <br />
    <asp:Label
        id="lblMessage"
        EnableViewState="false"
        Runat="server" />
    </div>
    </form>
</body>
</html>
