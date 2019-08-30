<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        lblResult.Text = "Search for: " & txtSearch.Text
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Button Default Button</title>
</head>
<body>
    <form id="form1" defaultbutton="btnSearch" runat="server">
    <div>
    
    <asp:Label
        id="lblSearch"
        Text="Search:"
        AssociatedControlID="txtSearch"
        Runat="server" />
    <asp:TextBox
        id="txtSearch"
        Runat="server" />
    <asp:Button
        id="btnSearch"
        Text="Search"
        OnClick="btnSearch_Click"
        Runat="server" />
    <asp:Button
        id="btnCancel"
        Text="Cancel"
        Runat="server" />    
    
    <hr />
    
    <asp:Label
        id="lblResult"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
