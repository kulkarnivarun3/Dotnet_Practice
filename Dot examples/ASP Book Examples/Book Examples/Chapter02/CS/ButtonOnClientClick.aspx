<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        lblResult.Text = "All pages deleted!";
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Button OnClientClick</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Button
        id="btnDelete"
        Text="Delete Website"
        OnClick="btnDelete_Click"
        OnClientClick="return confirm('Are you sure?');" 
        Runat="server" />
    
    <br /><br />
    
    <asp:Label
        id="lblResult"
        Runat="server" />    
    
    </div>
    </form>
</body>
</html>
