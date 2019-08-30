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
            PopulateTreeView()
        End If
    End Sub
 
    ''' <summary>
    ''' Get the data from the database and create the top-level
    ''' TreeView items
    ''' </summary>
    Private Sub PopulateTreeView()
        Dim treeViewData As DataTable = GetTreeViewData()
        AddTopTreeViewNodes(treeViewData)
    End Sub
 
    ''' <summary>
    ''' Use a DataAdapter and DataTable to grab the database data
    ''' </summary>
    ''' <returns></returns>
    Private Function GetTreeViewData() As DataTable
        ' Get Discuss table
        Dim selectCommand As String = "SELECT MessageId,ParentId,Subject FROM Discuss"
        Dim conString As String = WebConfigurationManager.ConnectionStrings("Discuss").ConnectionString
        Dim dad As SqlDataAdapter = New SqlDataAdapter(selectCommand, conString)
        Dim dtblDiscuss As DataTable = New DataTable()
        dad.Fill(dtblDiscuss)
        Return dtblDiscuss
    End Function
 
    ''' <summary>
    ''' Filter the data to get only the rows that have a
    ''' null ParentID (these are the top-level TreeView items)
    ''' </summary>
    Private Sub AddTopTreeViewNodes(ByVal treeViewData As DataTable)
        Dim view As DataView = New DataView(treeViewData)
        view.RowFilter = "ParentID IS NULL"
        Dim row As DataRowView
        For Each row In view
            Dim NewNode As TreeNode = New TreeNode(row("Subject").ToString(), row("MessageId").ToString())
            TreeView1.Nodes.Add(NewNode)
            AddChildTreeViewNodes(treeViewData, NewNode)
        Next
 
    End Sub
 
    ''' <summary>
    ''' Recursively add child TreeView items by filtering by ParentID
    ''' </summary>
    Private Sub AddChildTreeViewNodes(ByVal treeViewData As DataTable, ByVal parentTreeViewNode As TreeNode)
        Dim view As DataView = New DataView(treeViewData)
        view.RowFilter = "ParentID=" + parentTreeViewNode.Value
        Dim row As DataRowView
        For Each row In view
            Dim NewNode As TreeNode = New TreeNode(row("Subject").ToString(), row("MessageId").ToString())
            parentTreeViewNode.ChildNodes.Add(NewNode)
            AddChildTreeViewNodes(treeViewData, NewNode)
        Next
    End Sub
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
    </style>
    <title>TreeView Database</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:TreeView
        id="TreeView1"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
