<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        lblCounter.Text = (Int32.Parse(lblCounter.Text) + 1).ToString();
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show View State</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Button
        id="btnAdd"
        Text="Add"
        OnClick="btnAdd_Click"
        Runat="server" />
    
    <asp:Label
        id="lblCounter"
        Text="0"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
