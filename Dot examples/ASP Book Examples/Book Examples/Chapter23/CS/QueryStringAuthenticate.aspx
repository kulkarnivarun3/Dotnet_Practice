<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        string cookieName = FormsAuthentication.FormsCookieName;
        string cookieValue = FormsAuthentication.GetAuthCookie(User.Identity.Name, false).Value;
        lnkOtherDomain.NavigateUrl += String.Format("?{0}={1}", cookieName, cookieValue);
    }
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
