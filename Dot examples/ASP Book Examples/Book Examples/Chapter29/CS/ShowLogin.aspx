<%@ Page Language="C#" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        lblResults.Text = String.Format("You submitted {0} and {1}",
            Login1.UserName, Login1.Password);
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Login</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <custom:Login
        ID="Login1"
        Runat="server" />
    
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        OnClick="btnSubmit_Click" 
        Runat="server" />
    
    <hr />
    
    <asp:Label
        id="lblResults"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
