<%@ Page Language="VB" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    Private  Sub Page_Load()
        If Not Page.IsPostBack Then
            BuildTree()
        End If
    End Sub
    
    Sub BuildTree()
        
        ' Create MARS connection
        Dim connectionString As String = "MultipleActiveResultSets=True;" _
            & "Data Source=.\SQLExpress;Integrated Security=True;" _
            & "AttachDBFileName=|DataDirectory|MyDatabase.mdf;User Instance=True"
        Dim con As New SqlConnection(connectionString)
 
        ' Create Movie Categories command
        Dim cmdCategoriesText As String = "SELECT Id,Name FROM MovieCategories"
        Dim cmdCategories As New SqlCommand(cmdCategoriesText, con)
 
        ' Create Movie command
        Dim cmdMoviesText As String = "SELECT Title FROM Movies " _
            & "WHERE CategoryId=@CategoryID"
        Dim cmdMovies As New SqlCommand(cmdMoviesText, con)
        cmdMovies.Parameters.Add("@CategoryId", SqlDbType.Int)
 
        Using con
            con.Open()
 
            ' Iterate through categories
            Dim categories As SqlDataReader = cmdCategories.ExecuteReader()
            While categories.Read()
                ' Add category node
                Dim id As Integer = categories.GetInt32(0)
                Dim name As String = categories.GetString(1)
                Dim catNode As New TreeNode(name)
                TreeView1.Nodes.Add(catNode)
 
                ' Iterate through matching movies
                cmdMovies.Parameters("@CategoryId").Value = id
                Dim movies As SqlDataReader = cmdMovies.ExecuteReader()
                While movies.Read()
                    ' Add movie node
                    Dim title As String = movies.GetString(0)
                    Dim movieNode As New TreeNode(title)
                    catNode.ChildNodes.Add(movieNode)
                End While
                movies.Close()
            End While
        End Using
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show MARS</title>
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
