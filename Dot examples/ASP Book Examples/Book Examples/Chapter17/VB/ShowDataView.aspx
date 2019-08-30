<%@ Page Language="VB" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    Sub Page_Load()
        If IsNothing(Session("MoviesToSort")) Then
            Dim connectionString As String = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
            Dim dad As New SqlDataAdapter("SELECT Id,Title,Director FROM Movies", connectionString)
            Dim dtblMovies As New DataTable()
            dad.Fill(dtblMovies)
            Session("MoviesToSort") = dtblMovies.DefaultView
        End If
 
        If Not Page.IsPostBack Then
            BindMovies()
        End If
    End Sub
 
    Private  Sub BindMovies()
        grdMovies.DataSource = Session("MoviesToSort")
        grdMovies.DataBind()
    End Sub
 
    Protected  Sub grdMovies_Sorting(ByVal sender As Object, ByVal e As GridViewSortEventArgs)
        Dim dvwMovies As DataView = CType(Session("MoviesToSort"), DataView)
        dvwMovies.Sort = e.SortExpression
        BindMovies()
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show DataView</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        AllowSorting="true"
        OnSorting="grdMovies_Sorting" 
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
