<%@ Page Language="C#" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        // Add first node
        TreeNode parentNode = new TreeNode("configuration");
        TreeView1.Nodes.Add(parentNode);
        
        // Start from the root section group
        Configuration config = WebConfigurationManager.OpenMachineConfiguration();
        
        // Show child section groups
        AddChildSectionGroups(parentNode, config.RootSectionGroup);
        
        // Show child sections
        AddChildSections(parentNode, config.RootSectionGroup);
    }

    private void AddChildSectionGroups(TreeNode parentNode, ConfigurationSectionGroup parentConfigSectionGroup)
    {
        foreach (ConfigurationSectionGroup configSectionGroup in parentConfigSectionGroup.SectionGroups)
        {
            TreeNode childNode = new TreeNode(configSectionGroup.SectionGroupName);
            parentNode.ChildNodes.Add(childNode);
            AddChildSectionGroups(childNode, configSectionGroup);
            AddChildSections(childNode, configSectionGroup);
        }
    }

    private void AddChildSections(TreeNode parentNode, ConfigurationSectionGroup parentConfigSectionGroup)
    {
        foreach (ConfigurationSection configSection in parentConfigSectionGroup.Sections)
        {
            TreeNode childNode = new TreeNode(configSection.SectionInformation.Name);
            parentNode.ChildNodes.Add(childNode);
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Config Contents</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:TreeView
        id="TreeView1"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
