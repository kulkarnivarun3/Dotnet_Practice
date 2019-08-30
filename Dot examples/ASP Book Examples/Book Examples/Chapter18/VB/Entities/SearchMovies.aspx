<%@ Page Language="VB" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Data.Linq" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim conString As String = WebConfigurationManager.ConnectionStrings("con").ConnectionString
        Dim db As New DataContext(conString)
        Dim tMovie = db.GetTable(Of Movie)()

        grdMovies.DataSource = tMovie.Where(Function(m) m.Director.Contains(txtDirector.Text))
        grdMovies.DataBind()
    End Sub
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
