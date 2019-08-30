<%@ Page Language="C#" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        CompilationSection section = (CompilationSection)WebConfigurationManager.GetSection("system.web/compilation");
        lblDebug1.Text = section.Debug.ToString();

        section = (CompilationSection)WebConfigurationManager.GetWebApplicationSection("system.web/compilation");
        lblDebug2.Text = section.Debug.ToString();
    }
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Config Relative</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    GetSection Debug:
    <asp:Label
        id="lblDebug1"
        Runat="server" />

    <br /><br />  
    
    GetWebApplicationSection Debug:
    <asp:Label
        id="lblDebug2"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
