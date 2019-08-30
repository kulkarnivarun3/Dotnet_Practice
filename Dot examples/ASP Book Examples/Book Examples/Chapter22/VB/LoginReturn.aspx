<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim dest As String = Request.QueryString("ReturnUrl")
            Login1.CreateUserUrl = "~/CreateUserWizardReturn.aspx?ReturnUrl=" & Server.UrlEncode(dest)
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Login Return</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:Login
        id="Login1"
        CreateUserText="Register"
        CreateUserUrl="~/CreateUserWizardReturn.aspx"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
