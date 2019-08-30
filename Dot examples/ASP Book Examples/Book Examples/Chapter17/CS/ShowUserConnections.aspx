<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    
    void Page_Load()
    {
        string connectionString = @"Min Pool Size=10;Data Source=.\SQLExpress;Integrated Security=True;AttachDbFileName=|DataDirectory|MyDatabase.mdf;User Instance=True";
        SqlConnection con = new SqlConnection(connectionString);
        SqlCommand cmd = new SqlCommand("SELECT * FROM master..sysprocesses WHERE hostname<>''", con);
        using (con)
        {
            con.Open();
            grdStats.DataSource = cmd.ExecuteReader();
            grdStats.DataBind();
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        td,th
        {
            padding:2px;
        }
    </style>
    <title>Show User Connections</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <h1>User Connections</h1>
    
    <asp:GridView
        id="grdStats"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
