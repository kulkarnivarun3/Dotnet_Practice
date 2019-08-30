<%@ Page Language="C#" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    /// <summary>
    /// Validation function that is called on both the client and server
    /// </summary>
    protected void AjaxValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (UserNameExists(args.Value))
            args.IsValid = false;
        else
            args.IsValid = true;
    }
    
    /// <summary>
    /// Returns true when user name already exists
    /// in Users database table
    /// </summary>
    private bool UserNameExists(string userName)
    {
        string conString = WebConfigurationManager.ConnectionStrings["UsersDB"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE UserName=@UserName", con);
        cmd.Parameters.AddWithValue("@UserName", userName);
        bool result = false;
        using (con)
        {
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            if (count > 0)
                result = true;
        }
        return result;
    }

    /// <summary>
    /// Insert new user name to Users database table
    /// </summary>
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string conString = WebConfigurationManager.ConnectionStrings["UsersDB"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand("INSERT Users (UserName,FavoriteColor) VALUES (@UserName,@FavoriteColor)", con);
        cmd.Parameters.AddWithValue("@UserName", txtUserName.Text);
        cmd.Parameters.AddWithValue("@FavoriteColor", txtFavoriteColor.Text);
        using (con)
        {
            con.Open();
            cmd.ExecuteNonQuery();
        }
        txtUserName.Text = String.Empty;
        txtFavoriteColor.Text = String.Empty;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Show AjaxValidator</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblUserName"
        Text="User Name:"
        AssociatedControlID="txtUserName"
        Runat="server" />
    <asp:TextBox
        id="txtUserName"
        Runat="server" />
    <custom:AjaxValidator
        id="AjaxValidator1"
        ControlToValidate="txtUserName"
        Text="User name already taken!"
        OnServerValidate="AjaxValidator1_ServerValidate" 
        Runat="server" />
    
    <br /><br />
    <asp:Label
        id="lblFavoriteColor"
        Text="Favorite Color:"
        AssociatedControlID="txtFavoriteColor"
        Runat="server" />
    <asp:TextBox
        id="txtFavoriteColor"
        Runat="server" />

    <br /><br />
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        Runat="server" OnClick="btnSubmit_Click" />
    
    </div>
    </form>
</body>
</html>
