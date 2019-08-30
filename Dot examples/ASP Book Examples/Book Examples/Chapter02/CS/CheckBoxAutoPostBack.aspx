<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void chkNewsletter_CheckedChanged(object sender, EventArgs e)
    {
        lblResult.Text = chkNewsletter.Checked.ToString();
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>CheckBox AutoPostBack</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:CheckBox
        id="chkNewsletter"
        Text="Receive Newsletter?"
        AutoPostBack="true"
        OnCheckedChanged="chkNewsletter_CheckedChanged" 
        Runat="server" />
    <hr />
    
    <asp:Label
        id="lblResult"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
