<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    Sub Login1_Authenticate(ByVal sender As Object, ByVal e As AuthenticateEventArgs)
        Dim userName As String = Login1.UserName
        Dim password As String = Login1.Password
        e.Authenticated = FormsAuthentication.Authenticate(userName, password)
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Login Custom</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:Login
        id="Login1"
        OnAuthenticate="Login1_Authenticate"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
