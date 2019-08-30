<%@ Page Language="C#" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        CompilationSection section = (CompilationSection)WebConfigurationManager.GetWebApplicationSection("system.web/compilation");
        lblDebug.Text = section.Debug.ToString();
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Config App</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    Debug Mode:
    <asp:Label
        id="lblDebug"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
