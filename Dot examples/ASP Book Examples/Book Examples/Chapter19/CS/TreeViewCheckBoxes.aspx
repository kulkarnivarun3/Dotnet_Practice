<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void btnSubscribe_Click(object sender, EventArgs e)
    {
        foreach (TreeNode node in TreeView1.CheckedNodes)
            bltSubscribed.Items.Add(node.Text);
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>TreeView CheckBoxes</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    Select the Newsgroups which you 
    would like to join: 
    
    <br />
    
    <asp:TreeView
        id="TreeView1"
        ShowCheckBoxes="Leaf"
        Runat="server">
        <Nodes>
        <asp:TreeNode
            Text="Programming">
            <asp:TreeNode Text="ASP.NET" />
            <asp:TreeNode Text="JAVA" />
            <asp:TreeNode Text="Cold Fusion" />
        </asp:TreeNode>
        <asp:TreeNode
            Text="Sports">
            <asp:TreeNode Text="Baseball" />
            <asp:TreeNode Text="Hockey" />
            <asp:TreeNode Text="Football" />
        </asp:TreeNode>        
        </Nodes>
    </asp:TreeView>    
    
    <br />
    
    <asp:Button
        id="btnSubscribe"
        Text="Subscribe"
        OnClick="btnSubscribe_Click"
        Runat="server" />
    
    <hr />
    
    You selected:
    
    <asp:BulletedList
        id="bltSubscribed"
        EnableViewState="false"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
