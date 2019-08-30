<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub btnRemove_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim userToUnlock As MembershipUser = Membership.GetUser(txtUserName.Text)
        If IsNothing(userToUnlock) Then
            lblMessage.Text = "User not found!"
        Else
            userToUnlock.UnlockUser()
            lblMessage.Text = "Lock removed!"
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
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
        OnClick="btnRemove_Click"
        Runat="server" />
    <br />
    <asp:Label
        id="lblMessage"
        EnableViewState="false"
        Runat="server" />

    </div>
    </form>
</body>
</html>
