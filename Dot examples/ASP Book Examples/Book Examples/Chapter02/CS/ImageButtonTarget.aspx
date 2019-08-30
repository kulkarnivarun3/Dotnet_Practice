<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void btnTarget_Click(object sender, ImageClickEventArgs e)
    {
        if ((e.X > 90 && e.X < 110) && (e.Y > 90 && e.Y < 110))
            lblResult.Text = "You hit the target!";
        else
            lblResult.Text = "You missed!";
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>ImageButton Target</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:ImageButton
        id="btnTarget"
        ImageUrl="Target.gif"
        Runat="server" OnClick="btnTarget_Click" />
    
    <br /><br />
    
    <asp:Label
        id="lblResult"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
