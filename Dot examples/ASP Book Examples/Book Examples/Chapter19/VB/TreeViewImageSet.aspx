<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>TreeView ImageSet</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:TreeView
        id="TreeView1"
        ImageSet="XPFileExplorer"
        ShowLines="true"
        Runat="server">
        <Nodes>
        <asp:TreeNode
            Text="Home">
            <asp:TreeNode Text="Products">
                <asp:TreeNode Text="First Product" />
                <asp:TreeNode Text="Second Product" />
            </asp:TreeNode>
            <asp:TreeNode Text="Services">
                <asp:TreeNode Text="First Service" />
                <asp:TreeNode Text="Second Service" />
            </asp:TreeNode>    
        </asp:TreeNode>    
        </Nodes>
    </asp:TreeView>    
    
    
    </div>
    </form>
</body>
</html>
