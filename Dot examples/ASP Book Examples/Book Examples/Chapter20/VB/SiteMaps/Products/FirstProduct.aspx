<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    Private Sub Page_Load()
        If Not Page.IsPostBack Then
            Dim currentNode As SiteMapNode = SiteMap.CurrentNode
            Me.Title = currentNode.Title
            ltlBodyTitle.Text = currentNode.Title
            lblDescription.Text = currentNode.Description
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>First Product</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <h1><asp:Literal ID="ltlBodyTitle" runat="server" /></h1>
    
    <asp:Label
        id="lblDescription"
        Runat="server" />
        
    </div>
    </form>
</body>
</html>
