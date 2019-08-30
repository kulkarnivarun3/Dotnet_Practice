<%@ Page Language="VB" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        Dim config As Configuration = WebConfigurationManager.OpenMachineConfiguration()
        Dim section As AuthenticationSection = CType(config.GetSection("system.web/authentication"), AuthenticationSection)
        lblMode.Text = section.Mode.ToString()
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Config Machine</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    Authentication Mode Default Value:
    <asp:Label
        id="lblMode"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
