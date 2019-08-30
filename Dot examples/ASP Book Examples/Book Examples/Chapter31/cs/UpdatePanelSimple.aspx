<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>UpdatePanel Simple</title>
</head>
<body>
    <form id="form1" runat="server">
    
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    
    Page Time: <%= DateTime.Now.ToString("T") %>
    <br /><br />
    
    <asp:UpdatePanel
        id="up1"
        runat="server">
        <ContentTemplate>
        UpdatePanel Time: <%= DateTime.Now.ToString("T") %>
        <br />
        <asp:Button
            id="btn"
            Text="Update"
            runat="server" />
        </ContentTemplate>    
    </asp:UpdatePanel>
    
    </form>
</body>
</html>
