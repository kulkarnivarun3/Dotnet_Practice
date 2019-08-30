<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        lblMessage.Visible = True
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Simple Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:Button 
        id="btnSubmit"
        Text="Click Here!"
        OnClick="btnSubmit_Click"
        Runat="server" />
    
    <br /><br />
    
    <asp:Label
        id="lblMessage"
        Text="Thank You!"
        Visible="false"
        Runat="server" />
    
    
    </div>
    </form>
</body>
</html>
