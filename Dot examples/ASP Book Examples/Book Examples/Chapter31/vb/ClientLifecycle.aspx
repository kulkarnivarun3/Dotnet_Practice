<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Client Lifecycle</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server" />  
    
        <asp:UpdatePanel ID="up1" runat="server">
        <ContentTemplate>
            <asp:Button ID="btnAsync" Text="Async Postback" runat="server" />
        </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Button ID="Button1" Text="Normal Postback" runat="server" />
        
        <br /><br />
        <textarea id="TraceConsole" cols="60" rows="10"></textarea>
        
    </div>
    </form>
</body>
<script type="text/javascript">
   
  Sys.Application.add_init(application_init);
  
  function application_init()
  {
    Sys.Debug.trace("Application.Init");
    
    var prm = Sys.WebForms.PageRequestManager.getInstance();
    prm.add_initializeRequest( prm_initializeRequest );
    prm.add_beginRequest( prm_beginRequest );
    prm.add_pageLoading( prm_pageLoading );
    prm.add_pageLoaded( prm_pageLoaded );
    prm.add_endRequest( prm_endRequest );
  } 
   
  function pageLoad() 
  {
    Sys.Debug.trace("Application.Load");
  }
  
  function prm_initializeRequest()
  {
    Sys.Debug.trace("PageRequestManager.initializeRequest");
  }
  
  function prm_beginRequest()
  {
    Sys.Debug.trace("PageRequestManager.beginRequest");
  }
  
  function prm_pageLoading()
  {
    Sys.Debug.trace("PageRequestManager.pageLoading");
  }
  
  function prm_pageLoaded()
  {
    Sys.Debug.trace("PageRequestManager.pageLoaded");
  }
  
  function prm_endRequest()
  {
    Sys.Debug.trace("PageRequestManager.endRequest");
  }
  
  function pageUnload()
  {
    alert("Application.Unload");
  }  

</script>
</html>
