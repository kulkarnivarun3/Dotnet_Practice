<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    
    Sub Page_Load()
        Dim cookies As String() = Request.Cookies.AllKeys
        for each cookie As String in cookies
            BulletedList1.Items.Add("Deleting " & cookie)
            Response.Cookies(cookie).Expires = DateTime.Now.AddDays(-1)
        Next
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Delete All Cookies</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <h1>Delete All Cookies</h1>
    
    <asp:BulletedList
        id="BulletedList1"
        EnableViewState="false"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
