<%@ Page Language="C#" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    /// <summary>
    /// Only populate the TreeView when the page first loads
    /// </summary>
    void Page_Load()
    {
        if (!Page.IsPostBack)
            PopulateTreeView();
    }

    /// <summary>
    /// Get the data from the database and create the top-level
    /// TreeView items
    /// </summary>
    private void PopulateTreeView()
    {
        DataTable treeViewData = GetTreeViewData();
        AddTopTreeViewNodes(treeViewData);
    }
    
    /// <summary>
    /// Use a DataAdapter and DataTable to grab the database data
    /// </summary>
    /// <returns></returns>
    private DataTable GetTreeViewData()    
    {
        // Get Discuss table
        string selectCommand = "SELECT MessageId,ParentId,Subject FROM Discuss";
        string conString = WebConfigurationManager.ConnectionStrings["Discuss"].ConnectionString;
        SqlDataAdapter dad = new SqlDataAdapter(selectCommand, conString);
        DataTable dtblDiscuss = new DataTable();
        dad.Fill(dtblDiscuss);
        return dtblDiscuss;
    }

    /// <summary>
    /// Filter the data to get only the rows that have a
    /// null ParentID (these are the top-level TreeView items)
    /// </summary>
    private void AddTopTreeViewNodes(DataTable treeViewData)
    {
        DataView view = new DataView(treeViewData);
        view.RowFilter = "ParentID IS NULL";
        foreach (DataRowView row in view)
        {
            TreeNode newNode = new TreeNode(row["Subject"].ToString(), row["MessageId"].ToString());
            TreeView1.Nodes.Add(newNode);
            AddChildTreeViewNodes(treeViewData, newNode);
        }

    }

    /// <summary>
    /// Recursively add child TreeView items by filtering by ParentID
    /// </summary>
    private void AddChildTreeViewNodes(DataTable treeViewData, TreeNode parentTreeViewNode)
    {
        DataView view = new DataView(treeViewData);
        view.RowFilter = "ParentID=" + parentTreeViewNode.Value;
        foreach (DataRowView row in view)
        {
            TreeNode newNode = new TreeNode(row["Subject"].ToString(), row["MessageId"].ToString());
            parentTreeViewNode.ChildNodes.Add(newNode);
            AddChildTreeViewNodes(treeViewData, newNode);
        }
    }
    
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
