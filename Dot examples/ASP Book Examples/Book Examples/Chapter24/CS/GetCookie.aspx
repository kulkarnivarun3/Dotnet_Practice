<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        if (Request.Cookies["message"] != null)
            lblCookieValue.Text = Request.Cookies["message"].Value;
    }
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Get Cookie</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    The value of the message cookie is:
    <asp:Label
        id="lblCookieValue"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
