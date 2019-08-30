<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        Dim colCookies As New ArrayList()
        For i As Integer = 0 To Request.Cookies.Count - 1
            colCookies.Add(Request.Cookies(i))
        Next

        grdCookies.DataSource = colCookies
        grdCookies.DataBind()
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Get All Cookies</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdCookies"
        Runat="server"/>
        
    </div>
    </form>
</body>
</html>
