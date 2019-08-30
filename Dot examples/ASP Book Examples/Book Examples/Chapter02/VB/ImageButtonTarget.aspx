<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub btnTarget_Click(ByVal sender As Object, ByVal e As ImageClickEventArgs)
        If (e.X > 90 And e.X < 110) And (e.Y > 90 And e.Y < 110) Then
            lblResult.Text = "You hit the target!"
        Else
            lblResult.Text = "You missed!"
        End If
    End Sub
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
