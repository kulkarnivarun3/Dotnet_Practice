<%@ Page Language="VB" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        Dim results As New Dictionary(Of String, Boolean)()
        Dim rootDir As New DirectoryInfo(Request.PhysicalApplicationPath)
        Dim dirs As DirectoryInfo() = rootDir.GetDirectories()
        For Each dir As DirectoryInfo In dirs
            Dim path As String = "~/" & dir.Name
            Dim section As CompilationSection = CType(WebConfigurationManager.GetSection("system.web/compilation", path), CompilationSection)
            results.Add(path, section.Debug)
        Next
        grdResults.DataSource = results
        grdResults.DataBind()
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Config Path</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdResults"
        AutoGenerateColumns="false"
        Runat="server">
        <Columns>
        <asp:BoundField DataField="Key" HeaderText="Path" />
        <asp:BoundField DataField="Value" HeaderText="Debug Mode" />
        </Columns>
    </asp:GridView>

    </div>
    </form>
</body>
</html>
