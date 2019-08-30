<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

        void TreeView1_TreeNodePopulate(object s, TreeNodeEventArgs e)
        {
            for (int i=0;i<5;i++)
            {
                TreeNode newNode = new TreeNode();
                newNode.Text = String.Format("{0}.{1}", e.Node.Text, i);
                newNode.PopulateOnDemand = true;
                e.Node.ChildNodes.Add(newNode);
            }
        }
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>TreeView Populate On Demand</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <%=DateTime.Now.ToString("T") %>        
    
    <hr />

    <asp:TreeView 
        ID="TreeView1" 
        ExpandDepth="0"
        OnTreeNodePopulate="TreeView1_TreeNodePopulate" 
        Runat="server">
        <Nodes>
        <asp:TreeNode
            PopulateOnDemand="true"
            Text="Node 0" />
        </Nodes>
    </asp:TreeView>
    
    </div>
    </form>
</body>
</html>
