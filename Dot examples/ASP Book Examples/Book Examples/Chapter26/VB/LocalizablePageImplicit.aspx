<%@ Page Language="VB" UICulture="auto" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    Sub btnSubmit_Click(ByVal s As Object, ByVal e As EventArgs)
        lblMessage.Visible = True
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Localizable Page Implicit</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:Button 
        id="btnSubmit"
        meta:resourceKey="btnSubmit"
        Text="Click Me!"
        ToolTip="Click to show message"
        OnClick="btnSubmit_Click"
        Runat="server" />
    
    <br /><br />
    
    <asp:Label
        id="lblMessage"
        meta:resourceKey="lblMessage"
        Text="Thank You!"
        Visible="false"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
