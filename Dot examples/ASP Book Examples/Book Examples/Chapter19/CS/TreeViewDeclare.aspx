<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>TreeView Declare</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:TreeView
        id="TreeView1"
        Runat="server">
        <Nodes>
        <asp:TreeNode
            Text="Home"
            NavigateUrl="~/Default.aspx">
            <asp:TreeNode
                Text="Products">
                <asp:TreeNode
                    Text="First Product"
                    NavigateUrl="~/Products/FirstProduct.aspx" />
                <asp:TreeNode
                    Text="Second Product"
                    NavigateUrl="~/Products/SecondProduct.aspx" />
            </asp:TreeNode>
            <asp:TreeNode
                Text="Services">
                <asp:TreeNode
                    Text="First Service"
                    NavigateUrl="~/Services/FirstService.aspx" />
                <asp:TreeNode
                    Text="Second Service"
                    NavigateUrl="~/Services/SecondService.aspx" />
            </asp:TreeNode>    
        </asp:TreeNode>    
        </Nodes>
    </asp:TreeView>    
    
    
    </div>
    </form>
</body>
</html>
