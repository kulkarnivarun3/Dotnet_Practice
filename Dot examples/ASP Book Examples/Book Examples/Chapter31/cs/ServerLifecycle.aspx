<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    public ArrayList _log = new ArrayList();

    void Page_PreInit()
    {
        _log.Add("PreInit " + sm1.IsInAsyncPostBack);
    }

    void Page_Init()
    {
        _log.Add("Init " + sm1.IsInAsyncPostBack);
    }

    void Page_Load()
    {
        _log.Add("Load " + sm1.IsInAsyncPostBack);
    }
    
    void Page_PreRender()
    {
        _log.Add("PreRender " + sm1.IsInAsyncPostBack);
        
        // Show Lifecycle log
        bltLog.DataSource = _log;
        bltLog.DataBind();
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Server Lifecycle</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:ScriptManager
        id="sm1"
        runat="server" />
    
    <asp:UpdatePanel
        id="up1"
        runat="server">
        <ContentTemplate>
        <asp:Button 
            id="btnLog"
            Text="Show Server Page Lifecycle"
            Runat="server" />
        <asp:BulletedList
            id="bltLog"
            Runat="server" />
        
        </ContentTemplate>    
    </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
