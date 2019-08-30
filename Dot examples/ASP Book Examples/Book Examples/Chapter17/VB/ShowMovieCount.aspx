<%@ Page Language="VB" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    Private Sub Page_Load()
        lblMovieCount.Text = GetMovieCount().ToString()
    End Sub
 
    Private Function GetMovieCount() As Integer
        Dim result As Integer = 0
        Dim connectionString As String = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("GetMovieCount", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.ReturnValue
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Movie Count</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    There are
    <asp:Label
        id="lblMovieCount"
        Runat="server" />
    movies in the database.
    
    </div>
    </form>
</body>
</html>
