<%@ Page Language="VB" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    Private Sub Page_Load()
        If Not Page.IsPostBack Then
            BuildTree()
        End If
    End Sub
    
    Sub BuildTree()
        ' Create Connection
        Dim connectionString As String = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
        Dim con As New SqlConnection(connectionString)
 
        ' Create Movie Categories DataAdapter
        Dim dadCategories As New SqlDataAdapter("SELECT Id,Name FROM MovieCategories", con)
 
        ' Create Movies DataAdapter
        Dim dadMovies As New SqlDataAdapter("SELECT Title,CategoryId FROM Movies", con)
 
        ' Add the DataTables to the DataSet
        Dim dstMovies As New DataSet()
        Using con
            con.Open()
            dadCategories.Fill(dstMovies, "Categories")
            dadMovies.Fill(dstMovies, "Movies")
        End Using
 
        ' Add a DataRelation
        dstMovies.Relations.Add("Children", dstMovies.Tables("Categories").Columns("Id"), dstMovies.Tables("Movies").Columns("CategoryId"))
 
        ' Add the Movie Category nodes
        For Each categoryRow As DataRow In dstMovies.Tables("Categories").Rows
            Dim name As String = CType(categoryRow("Name"), String)
            Dim catNode As New TreeNode(name)
            TreeView1.Nodes.Add(catNode)
 
            ' Get matching movies
            Dim movieRows() As DataRow = categoryRow.GetChildRows("Children")
            For Each movieRow As DataRow In movieRows
                Dim title As String = CType(movieRow("Title"), String)
                Dim movieNode As New TreeNode(Title)
                catNode.ChildNodes.Add(movieNode)
            Next
        Next
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show DataSet</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:TreeView
        id="TreeView1"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
