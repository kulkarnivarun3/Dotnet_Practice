<%@ Page Language="VB" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    Private Sub Page_Load()
        Dim connectionString As String = "Min Pool Size=10;Data Source=.\SQLExpress;Integrated Security=True;AttachDbFileName=|DataDirectory|MyDatabase.mdf;User Instance=True"
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SELECT * FROM master..sysprocesses WHERE hostname<>''", con)
        Using con
            con.Open()
            grdStats.DataSource = cmd.ExecuteReader()
            grdStats.DataBind()
        End Using
    End Sub
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
