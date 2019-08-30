<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        If Not IsNothing(Request.Cookies("message")) Then
            lblCookieValue.Text = Request.Cookies("message").Value
        End If
    End Sub
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
