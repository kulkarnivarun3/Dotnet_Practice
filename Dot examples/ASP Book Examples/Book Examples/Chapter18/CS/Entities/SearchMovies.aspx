<%@ Page Language="C#" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Data.Linq" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string conString = WebConfigurationManager.ConnectionStrings["con"].ConnectionString;
        DataContext db = new DataContext(conString);  
        var tMovie = db.GetTable<Movie>();

        grdMovies.DataSource = tMovie.Where( m => m.Director.Contains(txtDirector.Text) );
        grdMovies.DataBind(); 
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>SearchMovies.aspx</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblDirector"
        Text="Director:"
        AssociatedControlID="txtDirector"
        Runat="server" />
    <asp:TextBox
        id="txtDirector"
        Runat="server" />
    <asp:Button
        id="btnSearch"
        Text="Search"
        OnClick="btnSearch_Click" 
        Runat="Server" />
        
    <br /><br />
        
    <asp:GridView
        id="grdMovies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
