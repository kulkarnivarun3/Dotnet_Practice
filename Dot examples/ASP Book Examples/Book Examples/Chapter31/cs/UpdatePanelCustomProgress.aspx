<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        System.Threading.Thread.Sleep(2000); // sleep 2 seconds
    }

</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>UpdatePanelCustomProgress</title>
    <style type="text/css">
        .normal
        {
            width:300px;
            padding:10px;
            margin:10px;
            border: solid 4px black;
        }
        
        .updating
        {
            width:300px;
            padding:10px;
            margin:10px;
            border: solid 4px orange;
        }
    
        .updated
        {
            width:300px;
            padding:10px;
            margin:10px;
            border: solid 4px green;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    
    <div id="panelContainer">
    <asp:UpdatePanel id="up1" UpdateMode="Conditional" runat="server">
    <ContentTemplate>
        <%= DateTime.Now.ToString("T") %>
        <asp:Button
            id="btnSubmit1"
            Text="Submit 1"
            OnClick="btnSubmit_Click" 
            Runat="server" /> 
    </ContentTemplate>
    </asp:UpdatePanel>

    <asp:UpdatePanel id="up2" UpdateMode="Conditional" runat="server">
    <ContentTemplate>
        <%= DateTime.Now.ToString("T") %>
        <asp:Button
            id="btnSubmit2"
            Text="Submit 2"
            OnClick="btnSubmit_Click" 
            Runat="server" /> 
    </ContentTemplate>
    </asp:UpdatePanel>
    </div>
    </form>
    <script type="text/javascript">
    var prm = Sys.WebForms.PageRequestManager.getInstance();
    prm.add_beginRequest(prm_beginRequest);
    prm.add_pageLoaded(prm_pageLoaded);
    
    function prm_beginRequest(sender, args)
    {
        var container = args.get_postBackElement().parentNode;
        container.className = 'updating';
    }

    function prm_pageLoaded(sender, args)
    {
        var panelsCreated = args.get_panelsCreated();
        for (var k=0;k<panelsCreated.length;k++)
            panelsCreated[k].className = 'normal';

        var panelsUpdated = args.get_panelsUpdated();
        for (var k=0;k<panelsUpdated.length;k++)
            panelsUpdated[k].className = 'updated';
    }

    </script>
</body>
</html>
