<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Protected Sub TreeView1_SelectedNodeChanged(ByVal sender As Object, ByVal e As EventArgs)
        lblMessage.Text = TreeView1.SelectedValue
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            background-color:silver;
        }
        .content
        {
            float:left;
            width:300px;
            height:500px;
            padding:20px;
            margin:10px;
            background-color:white;
        }
    </style>
    <title>TreeView Value</title>
</head>
<body>
    <form id="form1" runat="server">
    
    <div class="content">
    <asp:TreeView
        id="TreeView1"
        OnSelectedNodeChanged="TreeView1_SelectedNodeChanged"
        Runat="server" >
        <Nodes>
        <asp:TreeNode
            Text="Home"
            Value="Home">
            <asp:TreeNode
                Text="Products">
                <asp:TreeNode
                    Text="First Product"
                    Value="FirstProduct" />
                <asp:TreeNode
                    Text="Second Product"
                    Value="SecondProduct" />
            </asp:TreeNode>
            <asp:TreeNode
                Text="Services">
                <asp:TreeNode
                    Text="First Service"
                    Value="FirstService" />
                <asp:TreeNode
                    Text="Second Service"
                    Value="SecondService" />
            </asp:TreeNode>    
        </asp:TreeNode>    
        </Nodes>
    </asp:TreeView>    
    </div>
    
    <div class="content">
    You selected:
    <asp:Label
        id="lblMessage"
        EnableViewState="false"
        Runat="server" />
    </div>
    
    </form>
</body>
</html>
