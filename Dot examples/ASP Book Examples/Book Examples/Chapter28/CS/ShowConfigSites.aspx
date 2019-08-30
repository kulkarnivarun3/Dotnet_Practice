<%@ Page Language="C#" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.DirectoryServices" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    const string sitePath = "IIS://localhost/W3SVC/1/ROOT";
    
    void Page_Load()
    {
        if (!Page.IsPostBack)
        {
            dropVDirs.DataSource = GetVirtualDirectories();
            dropVDirs.DataBind();
        }
    }

    private List<String> GetVirtualDirectories()
    {
        List<String> dirs = new List<string>();
        DirectoryEntry site = new DirectoryEntry(sitePath);
        DirectoryEntries vdirs = site.Children;

        foreach (DirectoryEntry vdir in vdirs)
        {
            if (vdir.SchemaClassName == "IIsWebVirtualDir")
            {
                string vPath = vdir.Path.Remove(0, sitePath.Length);
                dirs.Add(vPath);
            }
        }
        return dirs;        
    }

    protected void btnSelect_Click(object sender, EventArgs e)
    {
        Configuration config = WebConfigurationManager.OpenWebConfiguration(dropVDirs.SelectedValue);
        AuthenticationSection section = (AuthenticationSection)config.GetSection("system.web/authentication");
        lblAuthenticationMode.Text = section.Mode.ToString();
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Config Sites</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblVirtualDirectory"
        Text="Virtual Directory:"
        AssociatedControlID="dropVDirs"
        Runat="server" />
    <asp:DropDownList
        id="dropVDirs"
        Runat="server" />
    <asp:Button
        id="btnSelect"
        Text="Select"
        OnClick="btnSelect_Click" 
        Runat="server" />
    
    <hr />
    
    Authentication Mode:
    <asp:Label
        id="lblAuthenticationMode"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
