<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>SiteMapPath Templates</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:SiteMapPath
        id="SiteMapPath1"
        Runat="server">
        <NodeTemplate>
        <asp:HyperLink
            id="lnkPage"
            Text='<%# Eval("Title") %>'
            NavigateUrl='<%# Eval("Url") %>'
            ToolTip='<%# Eval("Description") %>'
            Runat="server" /> 
        [<%# Eval("ChildNodes.Count") %>]
        </NodeTemplate>
    </asp:SiteMapPath>    
    
    <hr />
    
    <h1>SiteMapPath Templates</h1>
    
    
    </div>
    </form>
</body>
</html>
