<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        if (!Page.IsPostBack)
            BuildTree();
    }
    
    void BuildTree()
    {        
        // Create MARS connection
        string connectionString = @"MultipleActiveResultSets=True;"
            + @"Data Source=.\SQLExpress;Integrated Security=True;"
            + @"AttachDBFileName=|DataDirectory|MyDatabase.mdf;User Instance=True";
        SqlConnection con = new SqlConnection(connectionString);
        
        // Create Movie Categories command
        string cmdCategoriesText = "SELECT Id,Name FROM MovieCategories";
        SqlCommand cmdCategories = new SqlCommand(cmdCategoriesText, con);
        
        // Create Movie command
        string cmdMoviesText = "SELECT Title FROM Movies "
            + "WHERE CategoryId=@CategoryID";
        SqlCommand cmdMovies = new SqlCommand(cmdMoviesText, con);
        cmdMovies.Parameters.Add("@CategoryId", SqlDbType.Int);

        using (con)
        {
            con.Open();
            
            // Iterate through categories
            SqlDataReader categories = cmdCategories.ExecuteReader();
            while (categories.Read())
            {
                // Add category node
                int id = categories.GetInt32(0);
                string name = categories.GetString(1);
                TreeNode catNode = new TreeNode(name);
                TreeView1.Nodes.Add(catNode);

                // Iterate through matching movies
                cmdMovies.Parameters["@CategoryId"].Value = id;
                SqlDataReader movies = cmdMovies.ExecuteReader();
                while (movies.Read())
                {
                    // Add movie node
                    string title = movies.GetString(0);
                    TreeNode movieNode = new TreeNode(title);
                    catNode.ChildNodes.Add(movieNode);
                }
                movies.Close();
            }
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show MARS</title>
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
