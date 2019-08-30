<%@ Page Language="VB" Trace="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    Private Sub Page_Load()
        Dim movies As DataSet = CType(Cache("Movies"), DataSet)
        If IsNothing(movies) Then
            Trace.Warn("Retrieving movies from file system")
            movies = New DataSet()
            movies.ReadXml(MapPath("~/Movies.xml"))
            Dim fileDepend As New CacheDependency(MapPath("~/Movies.xml"))
            Cache.Insert("Movies", movies, fileDepend)
        End If
        grdMovies.DataSource = movies
        grdMovies.DataBind()
    End Sub
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
