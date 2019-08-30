<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        Dictionary<string, bool> results = new Dictionary<string, bool>();
        DirectoryInfo rootDir = new DirectoryInfo(Request.PhysicalApplicationPath);
        DirectoryInfo[] dirs = rootDir.GetDirectories();
        foreach (DirectoryInfo dir in dirs)
        {
            string path = "~/" + dir.Name;
            CompilationSection section = (CompilationSection)WebConfigurationManager.GetSection("system.web/compilation", path);
            results.Add(path, section.Debug);
        }
        grdResults.DataSource = results;
        grdResults.DataBind();
    }
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
