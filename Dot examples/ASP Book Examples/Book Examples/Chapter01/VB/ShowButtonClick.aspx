<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        Label1.Text = "Thanks!"
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Button Click</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Button
        id="btnSubmit"
        Text="Click Here"
        OnClick="btnSubmit_Click"
        Runat="server" />
    
    <br /><br />
    
    <asp:Label
        id="Label1"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
