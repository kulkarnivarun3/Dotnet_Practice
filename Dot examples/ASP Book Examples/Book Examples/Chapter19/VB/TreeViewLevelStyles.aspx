<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .nodeLevel1
        {
            font:40px Arial,Sans-Serif;
        }
        .nodeLevel2
        {
            font:20px Arial,Sans-Serif;
        }
        .nodeLevel3
        {
            font:10px Arial,Sans-Serif;
        }        
    </style>
    <title>TreeView Level Styles</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:TreeView
        id="TreeView1"
        Runat="server">
        <LevelStyles>
        <asp:TreeNodeStyle CssClass="nodeLevel1" />
        <asp:TreeNodeStyle CssClass="nodeLevel2" />
        <asp:TreeNodeStyle CssClass="nodeLevel3" />
        </LevelStyles>
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
