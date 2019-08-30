<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        SqlCommand cmd = new SqlCommand("SELECT BoxOfficeTotals FROM Movies WHERE Title=@Title", con);
        cmd.Parameters.AddWithValue("@Title", txtTitle.Text);
        using (con)
        {
            con.Open();
            Object result = cmd.ExecuteScalar();
            if (result != null)
                lblResult.Text = String.Format("{0:c}", result);
            else
                lblResult.Text = "No match!";
        }
        
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Execute Scalar</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <h1>Box Office Totals</h1>
    
    <asp:Label
        id="lblTitle"
        Text="Movie Title:"
        AssociatedControlID="txtTitle"
        Runat="server" />
    
    <asp:TextBox
        id="txtTitle"
        Runat="server" />
    
    <asp:Button
        id="btnSearch"
        Text="Search"
        OnClick="btnSearch_Click"
        Runat="server" />
    
    <hr />
    
    <asp:Label
        id="lblResult"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
