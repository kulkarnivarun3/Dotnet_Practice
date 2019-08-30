<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        If Not IsNothing(Request.Cookies("preferences")) Then
            lblFirstName.Text = Request.Cookies("preferences")("firstName")
            lblLastName.Text = Request.Cookies("preferences")("lastName")
            lblFavoriteColor.Text = Request.Cookies("preferences")("favoriteColor")
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Get Cookie Values</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    First Name:
    <asp:Label
        id="lblFirstName"
        Runat="server" />
    <br />
    Last Name:
    <asp:Label
        id="lblLastName"
        Runat="server" />
    <br />
    Favorite Color:
    <asp:Label
        id="lblFavoriteColor"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
