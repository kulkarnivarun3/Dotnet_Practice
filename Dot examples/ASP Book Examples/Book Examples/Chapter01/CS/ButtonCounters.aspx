<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void Button_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        btn.Text = (Int32.Parse(btn.Text) + 1).ToString();
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Button Counters</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    First Counter:
    <asp:Button
        id="Button1"
        Text="0"
        OnClick="Button_Click" 
        Runat="server" />
        
    <br /><br />    
    
    Second Counter:    
    <asp:Button
        id="Button2"
        Text="0"
        OnClick="Button_Click" 
        Runat="server" />    
    
    </div>
    </form>
</body>
</html>
