<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub btnAdd_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Cookies("message").Value = txtCookieValue.Text
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Set Cookie</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblCookieValue"
        Text="Cookie Value:"
        AssociatedControlID="txtCookieValue"
        Runat="server" />
    <asp:TextBox
        id="txtCookieValue"
        Runat="server" />
    <asp:Button
        id="btnAdd"
        Text="Add Value"
        OnClick="btnAdd_Click" 
        Runat="server" />
        
    </div>
    </form>
</body>
</html>
