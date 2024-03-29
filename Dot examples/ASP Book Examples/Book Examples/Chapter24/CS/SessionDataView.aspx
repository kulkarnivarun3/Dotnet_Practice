<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    DataView dvMovies;
    
    /// <summary>
    /// Load the Movies
    /// </summary>
    void Page_Load()
    {
        dvMovies = (DataView)Session["Movies"];
        if (dvMovies == null)
        {
            string conString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
            SqlDataAdapter dad = new SqlDataAdapter("SELECT Id,Title,Director FROM Movies", conString);
            DataTable dtblMovies = new DataTable();
            dad.Fill(dtblMovies);
            dvMovies = new DataView(dtblMovies);
            Session["Movies"] = dvMovies;
        }
    }

    /// <summary>
    /// Sort the Movies
    /// </summary>
    protected void grdMovies_Sorting(object sender, GridViewSortEventArgs e)
    {
        dvMovies.Sort = e.SortExpression;
    }

    /// <summary>
    /// Render the Movies
    /// </summary>
    void Page_PreRender()
    {
        grdMovies.DataSource = dvMovies;
        grdMovies.DataBind();
    }   
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Session DataView</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:GridView
        id="grdMovies"
        AllowSorting="true"
        EnableViewState="false"
        OnSorting="grdMovies_Sorting" 
        Runat="server" />
    <br />
    <asp:LinkButton
        id="lnkReload"
        Text="Reload Page"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
