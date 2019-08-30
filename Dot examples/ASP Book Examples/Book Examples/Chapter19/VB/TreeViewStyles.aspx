<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .treeNode
        {
            color:blue;
            font:14px Arial, Sans-Serif;
        }
        .rootNode
        {
            font-size:18px;
            width:100%;
            border-bottom:Solid 1px black;
        }
        .leafNode
        {
            border:Dotted 2px black;
            padding:4px;
            background-color:#eeeeee;
            font-weight:bold;
        }
    </style>
    <title>TreeView Styles</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:TreeView
        id="TreeView1"
        NodeStyle-CssClass="treeNode"
        RootNodeStyle-CssClass="rootNode"
        LeafNodeStyle-CssClass="leafNode"
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
