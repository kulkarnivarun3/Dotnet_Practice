<%@ Page Language="VB" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Sub Page_Load()
        Dim conString As String = WebConfigurationManager.ConnectionStrings("con").ConnectionString
        Dim con as new SqlConnection(conString)
        Dim cmd as new SqlCommand("SELECT Id, Title FROM Movie", con)
        grdMovies.DataSource = GenericMethods.GetListFromCommand(Of Movie)(cmd)
        grdMovies.DataBind()
    End Sub

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Show Generic Methods</title>
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
