<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    Sub Page_Load()
        bltAcceptLanguages.DataSource = Request.UserLanguages
        bltAcceptLanguages.DataBind()
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Accept Languages</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:BulletedList
        id="bltAcceptLanguages"
        Runat="server" />
        
    </div>
    </form>
</body>
</html>
