<%@ Page Language="VB" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    sub Page_Load()
        ' Add first node
        Dim parentNode As New TreeNode("configuration")
        TreeView1.Nodes.Add(parentNode)
        
        ' Start from the root section group
        Dim config As Configuration = WebConfigurationManager.OpenMachineConfiguration()
        
        ' Show child section groups
        AddChildSectionGroups(parentNode, config.RootSectionGroup)
        
        ' Show child sections
        AddChildSections(parentNode, config.RootSectionGroup)
    end sub

    Private Sub AddChildSectionGroups(ByVal parentNode As TreeNode, ByVal parentConfigSectionGroup As ConfigurationSectionGroup)
        For Each configSectionGroup As ConfigurationSectionGroup In parentConfigSectionGroup.SectionGroups
            Dim childNode As New TreeNode(configSectionGroup.SectionGroupName)
            parentNode.ChildNodes.Add(childNode)
            AddChildSectionGroups(childNode, configSectionGroup)
            AddChildSections(childNode, configSectionGroup)
        Next
    End Sub

    Private Sub AddChildSections(ByVal parentNode As TreeNode, ByVal parentConfigSectionGroup As ConfigurationSectionGroup)
        For Each configSection As ConfigurationSection In parentConfigSectionGroup.Sections
            Dim childNode As New TreeNode(configSection.SectionInformation.Name)
            parentNode.ChildNodes.Add(childNode)
        Next
    End Sub
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
