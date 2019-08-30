<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        lblMovieCount.Text = GetMovieCount().ToString();
    }

    private int GetMovieCount()
    {
        int result = 0;
        string connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        SqlCommand cmd = new SqlCommand("GetMovieCount", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
        using (con)
        {
            con.Open();
            cmd.ExecuteNonQuery();
            result = (int)cmd.Parameters["@ReturnVal"].Value;
        }
        return result;
    }
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
