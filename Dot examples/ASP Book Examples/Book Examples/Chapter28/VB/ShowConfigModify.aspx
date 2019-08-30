<%@ Page Language="VB" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    sub Page_Load()
        if Not Page.IsPostBack Then
            Dim config As Configuration = WebConfigurationManager.OpenWebConfiguration(Request.ApplicationPath)
            Dim section As CompilationSection = CType(config.GetSection("system.web/compilation"), CompilationSection)
            chkDebug.Checked = section.Debug
        end if
    end sub
    
    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim config As Configuration = WebConfigurationManager.OpenWebConfiguration(Request.ApplicationPath)
        Dim section As CompilationSection = CType(config.GetSection("system.web/compilation"), CompilationSection)
        section.Debug = chkDebug.Checked
        config.Save(ConfigurationSaveMode.Modified)
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Config Modify</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:CheckBox
        id="chkDebug"
        Text="Enable Debugging?"
        Runat="server" />
    <br /><br />
    <asp:Button
        id="btnUpdate"
        Text="Update"
        OnClick="btnUpdate_Click" 
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
