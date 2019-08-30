<%@ Page Language="VB" Trace="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    Private Sub Page_Load()
        Dim movies As DataTable = CType(Cache("Movies"), DataTable)
        If IsNothing(movies) Then
            movies = GetMoviesFromDB()
            Dim sqlDepend As New SqlCacheDependency("MyDatabase", "Movies")
            Cache.Insert("Movies", movies, sqlDepend)
        End If
        grdMovies.DataSource = movies
        grdMovies.DataBind()
    End Sub
 
    Private Function GetMoviesFromDB() As DataTable
        Trace.Warn("Retrieving data from database")
        Dim conString As String = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
        Dim dad As New SqlDataAdapter("SELECT Title,Director FROM Movies", conString)
        Dim movies As New DataTable()
        dad.Fill(movies)
        Return movies
    End Function
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
