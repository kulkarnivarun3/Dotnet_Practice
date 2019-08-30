<%@ Page Language="C#" Trace="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    
    void Page_Load()
    {
        DataSet movies = (DataSet)Cache["Movies"];
        if (movies == null)
        {
            Trace.Warn("Retrieving movies from file system");
            movies = new DataSet();
            movies.ReadXml(MapPath("~/Movies.xml"));
            CacheDependency fileDepend = new CacheDependency(MapPath("~/Movies.xml"));
            Cache.Insert("Movies", movies, fileDepend);
        }
        grdMovies.DataSource = movies;
        grdMovies.DataBind();
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show File Dependency</title>
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
