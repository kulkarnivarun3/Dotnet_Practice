<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Button_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim btn As Button = CType(sender, Button)
        btn.Text = (Int32.Parse(btn.Text) + 1).ToString()
    End Sub
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
