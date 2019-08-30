<%@ Page Language="C#" Trace="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        // Get movies from Cache
        DataSet movies = (DataSet)Cache["Movies"];
        
        // If movies not in cache, recreate movies
        if (movies == null)
        {
            movies = GetMoviesFromDB();
            Cache.Insert("Movies", movies, null, Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(5));
        }

        grdMovies.DataSource = movies;
        grdMovies.DataBind();
    }

    private DataSet GetMoviesFromDB()
    {
        Trace.Warn("Getting movies from database");
        string conString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
        SqlDataAdapter dad = new SqlDataAdapter("SELECT Title,Director FROM Movies", conString);
        DataSet movies = new DataSet();
        dad.Fill(movies);
        return movies;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Sliding Expiration</title>
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
