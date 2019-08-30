<%@ Page Language="C#" Trace="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        DataTable movies = (DataTable)Cache["Movies"];
        if (movies == null)
        {
            movies = GetMoviesFromDB();
            SqlCacheDependency sqlDepend = new SqlCacheDependency("MyDatabase", "Movies");
            Cache.Insert("Movies", movies, sqlDepend);
        }
        grdMovies.DataSource = movies;
        grdMovies.DataBind();
    }

    private DataTable GetMoviesFromDB()
    {
        Trace.Warn("Retrieving data from database");
        string conString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
        SqlDataAdapter dad = new SqlDataAdapter("SELECT Title,Director FROM Movies", conString);
        DataTable movies = new DataTable();
        dad.Fill(movies);
        return movies; 
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Polling SQL Data Cache</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
