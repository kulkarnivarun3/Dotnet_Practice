<%@ Page Language="C#" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        if (!Page.IsPostBack)
        {
            Configuration config = WebConfigurationManager.OpenWebConfiguration(Request.ApplicationPath);
            CompilationSection section = (CompilationSection)config.GetSection("system.web/compilation");
            chkDebug.Checked = section.Debug;
        }
    }
    
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        Configuration config = WebConfigurationManager.OpenWebConfiguration(Request.ApplicationPath);
        CompilationSection section = (CompilationSection)config.GetSection("system.web/compilation");
        section.Debug = chkDebug.Checked;
        config.Save(ConfigurationSaveMode.Modified);
    }
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
