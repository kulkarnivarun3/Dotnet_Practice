<%@ Page Language="VB" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    ''' <summary>
    ''' Only populate the TreeView when the page first loads
    ''' </summary>
    Private Sub Page_Load()
        If Not Page.IsPostBack Then
            PopulateTopNodes()
        End If
    End Sub
 
 
    ''' <summary>
    ''' Get the top level nodes (nodes with a null ParentId)
    ''' </summary>
    Private Sub PopulateTopNodes()
        Dim selectCommand As String = "SELECT MessageId,ParentId,Subject FROM Discuss WHERE ParentId IS NULL"
        Dim conString As String = WebConfigurationManager.ConnectionStrings("Discuss").ConnectionString
        Dim dad As New SqlDataAdapter(selectCommand, conString)
        Dim dtblMessages As New DataTable()
        dad.Fill(dtblMessages)
 
        For Each row As DataRow In dtblMessages.Rows
            Dim NewNode As New TreeNode(row("Subject").ToString(), row("MessageId").ToString())
            NewNode.PopulateOnDemand = True
            TreeView1.Nodes.Add(NewNode)
        Next
    End Sub
 
 
    ''' <summary>
    ''' Get the child nodes of the expanded node
    ''' </summary>
    Protected Sub TreeView1_TreeNodePopulate(ByVal sender As Object, ByVal e As TreeNodeEventArgs)
        Dim selectCommand As String = "SELECT MessageId,ParentId,Subject FROM Discuss WHERE ParentId=@ParentId"
        Dim conString As String = WebConfigurationManager.ConnectionStrings("Discuss").ConnectionString
        Dim dad As New SqlDataAdapter(selectCommand, conString)
        dad.SelectCommand.Parameters.AddWithValue("@ParentId", e.Node.Value)
        Dim dtblMessages As New DataTable()
        dad.Fill(dtblMessages)
 
        For Each row As DataRow In dtblMessages.Rows
            Dim NewNode As New TreeNode(row("Subject").ToString(), row("MessageId").ToString())
            NewNode.PopulateOnDemand = True
            e.Node.ChildNodes.Add(NewNode)
        Next
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
    </style>
    <title>TreeView AJAX</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <%= DateTime.Now.ToString("T") %>
    
    <hr />
    
    <asp:TreeView
        id="TreeView1"
        ExpandDepth="0"
        OnTreeNodePopulate="TreeView1_TreeNodePopulate"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
