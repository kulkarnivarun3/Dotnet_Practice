<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.DirectoryServices" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    const string wwwroot = @"c:\Inetpub";
    const string sitePath = @"IIS://localhost/W3SVC/1/ROOT";

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string newFolder = Path.Combine(wwwroot, txtVirtualDir.Text);

        CreateVirtualDirectory(newFolder, txtVirtualDir.Text, txtVirtualDir.Text);
        CreateConfiguration(txtVirtualDir.Text);
        
        // Show link to new site
        lnkNewSite.NavigateUrl = "http://localhost/" + txtVirtualDir.Text;
        lnkNewSite.Target = "_top";
        lnkNewSite.Visible = true;
    }
    
    private void CreateVirtualDirectory(string folderPath, string virtualDirectoryName, string appFriendlyName)
    {
        // Create new Folder
        Directory.CreateDirectory(folderPath);

        // Create Virtual Directory
        DirectoryEntry vRoot = new DirectoryEntry(sitePath);
        DirectoryEntry vDir = vRoot.Children.Add(virtualDirectoryName, "IIsWebVirtualDir");
        vDir.CommitChanges();
        vDir.Properties["Path"].Value = folderPath;
        vDir.Properties["DefaultDoc"].Value = "Default.aspx";
        vDir.Properties["DirBrowseFlags"].Value = 2147483648;
        vDir.CommitChanges();
        vRoot.CommitChanges();
        
        // Create Application (Isolated)
        vDir.Invoke("AppCreate2", 1);
        vDir.Properties["AppFriendlyName"].Value = appFriendlyName;
        vDir.CommitChanges();        
    }

    private void CreateConfiguration(string virtualPath)
    {
        // Open configuration
        Configuration config = WebConfigurationManager.OpenWebConfiguration("/" + virtualPath);
        
        // Set language and debug setting
        CompilationSection section = (CompilationSection)config.GetSection("system.web/compilation");
        section.DefaultLanguage = rdlLanguage.SelectedItem.Text;
        section.Debug = chkDebug.Checked;
        
        // Save configuration        
        config.Save(ConfigurationSaveMode.Modified);
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Provision Site</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblVirtualDir"
        Text="Virtual Directory:"
        AssociatedControlID="txtVirtualDir"
        Runat="server" />    
    <br />
    <asp:TextBox
        id="txtVirtualDir"
        Runat="server" />
    <br /><br />
    <asp:Label
        id="lblLanguage"
        Text="Default Language:"
        AssociatedControlID="rdlLanguage"
        Runat="server" />    
    <asp:RadioButtonList
        id="rdlLanguage"
        Runat="server">
        <asp:ListItem Text="VB" Selected="True" />    
        <asp:ListItem Text="C#" />
    </asp:RadioButtonList>    
    <br />
    <asp:CheckBox
        id="chkDebug"
        Text="Enable Debugging"
        Runat="server" />
    <br /><br />
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        OnClick="btnSubmit_Click" 
        Runat="server" />

    <hr />
    <asp:HyperLink
        id="lnkNewSite"
        Visible="false"
        Text="Go to New Site"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
