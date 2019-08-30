<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub btnAdd_Click(ByVal sender As Object, ByVal e As EventArgs)
        Label1.Text = (Int32.Parse(Label1.Text) + 1).ToString()
        Label2.Text = (Int32.Parse(Label2.Text) + 1).ToString()
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Disable View State</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    Label 1:
    <asp:Label
        id="Label1"
        EnableViewState="false"
        Text="0"
        Runat="server" />

    <br />

    Label 2:
    <asp:Label
        id="Label2"
        Text="0"
        Runat="server" />
    
    <br /><br />
    
    <asp:Button
        id="btnAdd"
        Text="Add"
        OnClick="btnAdd_Click" 
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
