<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub btnSubmit_Click(ByVal s As Object, ByVal e As EventArgs)
        Response.Cookies("preferences")("firstName") = txtFirstName.Text
        Response.Cookies("preferences")("lastName") = txtLastName.Text
        Response.Cookies("preferences")("favoriteColor") = txtFavoriteColor.Text
        Response.Cookies("preferences").Expires = DateTime.MaxValue
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Set Cookie Values</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblFirstName"
        Text="First Name:"
        AssociatedControlID="txtFirstName"
        Runat="server" />
    <br />    
    <asp:TextBox
        id="txtFirstName"
        Runat="server" />
    <br /><br />
    <asp:Label
        id="lblLastName"
        Text="Last Name:"
        AssociatedControlID="txtFirstName"
        Runat="server" />
    <br />    
    <asp:TextBox
        id="txtLastName"
        Runat="server" />
    <br /><br />
    <asp:Label
        id="lblFavoriteColor"
        Text="Favorite Color:"
        AssociatedControlID="txtFavoriteColor"
        Runat="server" />
    <br />    
    <asp:TextBox
        id="txtFavoriteColor"
        Runat="server" />
    <br /><br />
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        OnClick="btnSubmit_Click"
        Runat="server" />
    
    
    </div>
    </form>
</body>
</html>
