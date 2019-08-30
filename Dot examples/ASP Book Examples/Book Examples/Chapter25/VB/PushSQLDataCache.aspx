<%@ Page Language="VB" Trace="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    Private  Sub Page_Load()
        Dim movies As DataTable = CType(Cache("Movies"), DataTable)
        If IsNothing(movies) Then
            Trace.Warn("Retrieving data from database")
            Dim conString As String = WebConfigurationManager.ConnectionStrings("MyMovies").ConnectionString
            Dim dad As New SqlDataAdapter("SELECT Title,Director FROM dbo.Movies", conString)
            Dim sqlDepend As New SqlCacheDependency(dad.SelectCommand)
            movies = New DataTable()
            dad.Fill(movies)
 
            Cache.Insert("Movies", movies, sqlDepend)
        End If
        grdMovies.DataSource = movies
        grdMovies.DataBind()
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Push SQL Data Cache</title>
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
