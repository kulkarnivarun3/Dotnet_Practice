<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        Label1.Text = "Page Load"
    End Sub

    Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs)
        Label1.Text &= "<br />Button Click"
    End Sub

    Sub Page_PreRender()
        Label1.Text &= "<br />Page PreRender"
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Page Events</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Button
        id="Button1"
        Text="Click Here"
        OnClick="Button1_Click"
        Runat="server" />
    
    <br /><br />
    
    <asp:Label
        id="Label1"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
