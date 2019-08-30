<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        lblFirstName.Text = ProfileComponent.GetFirstNameFromProfile()
    End Sub

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Profile Component</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    First Name:
    <asp:Label
        id="lblFirstName"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
