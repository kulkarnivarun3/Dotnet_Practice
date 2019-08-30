<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        throw new Exception("Server Error");
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>UpdatePanel Error</title>
</head>
<body>
    <form id="form1" runat="server">

    <asp:ScriptManager
        id="sm1"
        Runat="server" />

    <asp:UpdatePanel
        id="up1"
        runat="server">
        <ContentTemplate>
        
        <asp:Button
            id="btnSubmit"
            Text="Submit"
            OnClick="btnSubmit_Click" 
            Runat="server" />
        
        </ContentTemplate>
    </asp:UpdatePanel>

    </form>
</body>
</html>
