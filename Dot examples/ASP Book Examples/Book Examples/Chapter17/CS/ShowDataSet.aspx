<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    
    void Page_Load()
    {
        if (!Page.IsPostBack)
            BuildTree();   
    }
    
    void BuildTree()
    {
        // Create Connection
        string connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        
        // Create Movie Categories DataAdapter
        SqlDataAdapter dadCategories = new SqlDataAdapter("SELECT Id,Name FROM MovieCategories", con);
        
        // Create Movies DataAdapter
        SqlDataAdapter dadMovies = new SqlDataAdapter("SELECT Title,CategoryId FROM Movies", con);
        
        // Add the DataTables to the DataSet
        DataSet dstMovies = new DataSet();
        using (con)
        {
            con.Open();
            dadCategories.Fill(dstMovies, "Categories");
            dadMovies.Fill(dstMovies, "Movies");
        }
        
        // Add a DataRelation
        dstMovies.Relations.Add("Children", dstMovies.Tables["Categories"].Columns["Id"], dstMovies.Tables["Movies"].Columns["CategoryId"]);
        
        // Add the Movie Category nodes
        foreach (DataRow categoryRow in dstMovies.Tables["Categories"].Rows)
        {
            string name = (string)categoryRow["Name"];
            TreeNode catNode = new TreeNode(name);
            TreeView1.Nodes.Add(catNode);

            // Get matching movies
            DataRow[] movieRows = categoryRow.GetChildRows("Children");
            foreach (DataRow movieRow in movieRows)
            {
                string title = (string)movieRow["Title"];
                TreeNode movieNode = new TreeNode(title);
                catNode.ChildNodes.Add(movieNode);   
            }
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show DataSet</title>
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
