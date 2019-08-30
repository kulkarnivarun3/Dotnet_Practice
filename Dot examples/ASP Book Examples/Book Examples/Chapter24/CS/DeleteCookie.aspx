<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        Response.Cookies[txtCookieName.Text].Expires = DateTime.Now.AddDays(-1);
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Delete Cookie</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblCookieName"
        Text="Cookie Name:"
        AssociatedControlID="txtCookieName"
        Runat="server" />
    <asp:TextBox
        id="txtCookieName"
        Runat="server" />
    <asp:Button
        id="btnDelete"
        Text="Delete Cookie"
        OnClick="btnDelete_Click" 
        Runat="server" />
        
    </div>
    </form>
</body>
</html>
