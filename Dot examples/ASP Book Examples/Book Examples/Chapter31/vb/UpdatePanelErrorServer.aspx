<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected sub btnSubmit_Click(sender as object, e as EventArgs)
        throw new Exception("Server Error")
    end sub

    protected sub sm1_AsyncPostBackError(sender as object, e as AsyncPostBackErrorEventArgs)
        sm1.AsyncPostBackErrorMessage = "A server error occured"
    end sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>UpdatePanel Error Server</title>
</head>
<body>
    <form id="form1" runat="server">

    <asp:ScriptManager
        id="sm1"
        OnAsyncPostBackError="sm1_AsyncPostBackError" 
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
