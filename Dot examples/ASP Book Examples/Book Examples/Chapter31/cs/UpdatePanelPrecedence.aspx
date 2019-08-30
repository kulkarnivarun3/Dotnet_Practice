<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        System.Threading.Thread.Sleep(3000); // sleep 3 seconds
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>UpdatePanel Precedence</title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    
    <asp:UpdatePanel ID="up1" UpdateMode="Conditional" runat="server">
    <ContentTemplate>
        <%= DateTime.Now.ToString("T") %>
        <asp:Button
            id="btnSubmit1"
            Text="Submit 1"
            OnClick="btnSubmit_Click" 
            Runat="server"/>
    </ContentTemplate>
    </asp:UpdatePanel>
    
    <asp:UpdatePanel ID="up2" UpdateMode="Conditional" runat="server">
    <ContentTemplate>
        <%= DateTime.Now.ToString("T") %>
        <asp:Button
            id="btnSubmit2"
            Text="Submit 2"
            OnClick="btnSubmit_Click" 
            Runat="server" />
    </ContentTemplate>
    </asp:UpdatePanel>
    
    </form>
    <script type="text/javascript">

    var prm = Sys.WebForms.PageRequestManager.getInstance();
    prm.add_initializeRequest( prm_initializeRequest );    

    var prevPostBackElementId;
    
    function prm_initializeRequest(sender, args)
    {
        if (prm.get_isInAsyncPostBack())
        {
            if (prevPostBackElementId == 'btnSubmit1')
            {
                alert('Still Processing btnSubmit1 Request');
                args.set_cancel(true);
            }
        }
        prevPostBackElementId = args.get_postBackElement().id;
    }
    </script>

</body>
</html>
