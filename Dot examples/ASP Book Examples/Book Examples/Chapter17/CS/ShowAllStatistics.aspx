<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    
    void Page_Load()
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        SqlCommand cmd = new SqlCommand("WAITFOR DELAY '0:0:03';SELECT Title,Director FROM Movies", con);
        con.StatisticsEnabled = true;
        using (con)
        {
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
        }
        grdStats.DataSource = con.RetrieveStatistics();
        grdStats.DataBind();
    }
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        td,th
        {
            padding:4px 20px;
        }
    </style>
    <title>Show All Statistics</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <h1>Connection Statistics</h1>
    
    <asp:GridView
        id="grdStats"
        AutoGenerateColumns="false"
        Runat="server">
        <Columns>
        <asp:BoundField DataField="Key" HeaderText="Key" />
        <asp:BoundField DataField="Value" HeaderText="Value" />
        </Columns>    
    </asp:GridView>
    
    
    </div>
    </form>
</body>
</html>
