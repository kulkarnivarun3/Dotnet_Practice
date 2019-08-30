<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        Dim cookieName As String = FormsAuthentication.FormsCookieName
        Dim cookieValue As String = FormsAuthentication.GetAuthCookie(User.Identity.Name, False).Value
        lnkOtherDomain.NavigateUrl &= String.Format("?{0}={1}", cookieName, cookieValue)
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Query String Authenticate</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:HyperLink
        id="lnkOtherDomain"
        Text="Link to Other Domain"
        NavigateUrl="http://www.OtherDomain.com/Secret.aspx"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
