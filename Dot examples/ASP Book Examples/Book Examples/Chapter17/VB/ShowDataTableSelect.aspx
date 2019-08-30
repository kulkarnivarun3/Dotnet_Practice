<%@ Page Language="VB" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        ' Get movies DataTable from Cache
        Dim dtblMovies As DataTable = CType(Cache("MoviesToFilter"), DataTable)
        If IsNothing(dtblMovies) Then
            dtblMovies = GetMoviesFromDB()
            Cache("MoviesToFilter") = dtblMovies
        End If
 
        ' Select matching rows
        Dim filter As String = String.Format("Title LIKE '{0}*'", txtTitle.Text)
        Dim rows() As DataRow = dtblMovies.Select(filter, "Title")
 
        ' Bind to GridView
        grdMovies.DataSource = rows
        grdMovies.DataBind()
    End Sub
 
    Private Function GetMoviesFromDB() As DataTable
        Dim connectionString As String = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
        Dim dad As New SqlDataAdapter("SELECT Title, Director FROM Movies", connectionString)
        Dim dtblMovies As New DataTable()
        dad.Fill(dtblMovies)
        Return dtblMovies
    End Function
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        th, td
        {
            padding:5px;
        }
    </style>
    <title>Show DataTable Select</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:TextBox
        id="txtTitle"
        Tooltip="Search"
        Runat="server" />
    <asp:Button
        id="btnSearch"
        Text="Search"
        Runat="server" OnClick="btnSearch_Click" />    
    
    <hr />
    
    <asp:GridView
        id="grdMovies"
        AutoGenerateColumns="false"
        Runat="server">
        <Columns>
        <asp:TemplateField HeaderText="Title">
        <ItemTemplate>
            <%# CType(Container.DataItem,DataRow)("Title") %>
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Director">
        <ItemTemplate>
            <%#CType(Container.DataItem, DataRow)("Director")%>
        </ItemTemplate>
        </asp:TemplateField>
        </Columns>
        </asp:GridView>
    
    </div>
    </form>
</body>
</html>
