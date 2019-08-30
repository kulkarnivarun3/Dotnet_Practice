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
            PopulateTopNodes();
    }

    
    /// <summary>
    /// Get the top level nodes (nodes with a null ParentId)
    /// </summary>
    private void PopulateTopNodes()
    {
        string selectCommand = "SELECT MessageId,ParentId,Subject FROM Discuss WHERE ParentId IS NULL";
        string conString = WebConfigurationManager.ConnectionStrings["Discuss"].ConnectionString;
        SqlDataAdapter dad = new SqlDataAdapter(selectCommand, conString);
        DataTable dtblMessages = new DataTable();
        dad.Fill(dtblMessages);

        foreach (DataRow row in dtblMessages.Rows)
        {
            TreeNode newNode = new TreeNode(row["Subject"].ToString(), row["MessageId"].ToString());
            newNode.PopulateOnDemand = true;
            TreeView1.Nodes.Add(newNode);
        }
    }

    
    /// <summary>
    /// Get the child nodes of the expanded node
    /// </summary>
    protected void TreeView1_TreeNodePopulate(object sender, TreeNodeEventArgs e)
    {
        string selectCommand = "SELECT MessageId,ParentId,Subject FROM Discuss WHERE ParentId=@ParentId";
        string conString = WebConfigurationManager.ConnectionStrings["Discuss"].ConnectionString;
        SqlDataAdapter dad = new SqlDataAdapter(selectCommand, conString);
        dad.SelectCommand.Parameters.AddWithValue("@ParentId", e.Node.Value);
        DataTable dtblMessages = new DataTable();
        dad.Fill(dtblMessages);

        foreach (DataRow row in dtblMessages.Rows)
        {
            TreeNode newNode = new TreeNode(row["Subject"].ToString(), row["MessageId"].ToString());
            newNode.PopulateOnDemand = true;
            e.Node.ChildNodes.Add(newNode);
        }
    }
   
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
