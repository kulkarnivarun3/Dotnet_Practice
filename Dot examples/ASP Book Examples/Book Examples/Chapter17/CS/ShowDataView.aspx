<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        if (Session["MoviesToSort"] == null)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
            SqlDataAdapter dad = new SqlDataAdapter("SELECT Id,Title,Director FROM Movies", connectionString);
            DataTable dtblMovies = new DataTable();
            dad.Fill(dtblMovies);
            Session["MoviesToSort"] = dtblMovies.DefaultView;
        }

        if (!Page.IsPostBack)
            BindMovies();
    }

    void BindMovies()
    {
        grdMovies.DataSource = Session["MoviesToSort"];
        grdMovies.DataBind();
    }

    protected void grdMovies_Sorting(object sender, GridViewSortEventArgs e)
    {
        DataView dvwMovies = (DataView)Session["MoviesToSort"];
        dvwMovies.Sort = e.SortExpression;
        BindMovies();
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show DataView</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        AllowSorting="true"
        OnSorting="grdMovies_Sorting" 
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
