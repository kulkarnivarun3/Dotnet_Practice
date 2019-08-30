<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        // Get movies DataTable from Cache
        DataTable dtblMovies = (DataTable)Cache["MoviesToFilter"];
        if (dtblMovies == null)
        {
            dtblMovies = GetMoviesFromDB();
            Cache["MoviesToFilter"] = dtblMovies;
        }
        
        // Select matching rows
        string filter = String.Format("Title LIKE '{0}*'", txtTitle.Text);
        DataRow[] rows = dtblMovies.Select(filter, "Title");
        
        // Bind to GridView
        grdMovies.DataSource = rows;
        grdMovies.DataBind();
    }

    private DataTable GetMoviesFromDB()
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
        SqlDataAdapter dad = new SqlDataAdapter("SELECT Title, Director FROM Movies", connectionString);
        DataTable dtblMovies = new DataTable();
        dad.Fill(dtblMovies);
        return dtblMovies;

    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        th, td
        {
            padding:5px;
        }
    </style>
    <title>Show DataTable Select</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:TextBox
        id="txtTitle"
        Tooltip="Search"
        Runat="server" />
    <asp:Button
        id="btnSearch"
        Text="Search"
        Runat="server" OnClick="btnSearch_Click" />    
    
    
    <hr />
    
    <asp:GridView
        id="grdMovies"
        AutoGenerateColumns="false"
        Runat="server">
        <Columns>
        <asp:TemplateField HeaderText="Title">
        <ItemTemplate>
            <%# ((DataRow)Container.DataItem)["Title"] %>
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Director">
        <ItemTemplate>
            <%# ((DataRow)Container.DataItem)["Director"] %>
        </ItemTemplate>
        </asp:TemplateField>
        </Columns>
        </asp:GridView>
    
    </div>
    </form>
</body>
</html>
