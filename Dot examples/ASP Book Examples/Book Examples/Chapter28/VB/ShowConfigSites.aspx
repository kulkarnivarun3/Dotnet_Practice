<%@ Page Language="VB" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.DirectoryServices" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Const sitePath As String = "IIS://localhost/W3SVC/1/ROOT"
    
    Sub Page_Load()
        If Not Page.IsPostBack Then
            dropVDirs.DataSource = GetVirtualDirectories()
            dropVDirs.DataBind()
        End If
    End Sub

    Private Function GetVirtualDirectories() As List(Of String)
        Dim dirs As New List(Of String)()
        Dim site As New DirectoryEntry(sitePath)
        Dim vdirs As DirectoryEntries = site.Children

        For Each vdir As DirectoryEntry In vdirs
            If vdir.SchemaClassName = "IIsWebVirtualDir" Then
                Dim vPath As String = vdir.Path.Remove(0, sitePath.Length)
                dirs.Add(vPath)
            End If
        Next
        Return dirs
    End Function

    Protected Sub btnSelect_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim config As Configuration = WebConfigurationManager.OpenWebConfiguration(dropVDirs.SelectedValue)
        Dim section As AuthenticationSection = CType(config.GetSection("system.web/authentication"), AuthenticationSection)
        lblAuthenticationMode.Text = section.Mode.ToString()
    End Sub
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
