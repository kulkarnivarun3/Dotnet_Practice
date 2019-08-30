<%@ Page Language="VB" %>
<%@ Import Namespace="AspNetUnleashed" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        ' Get configuration
        Dim section As AdminUsersSection = CType(WebConfigurationManager.GetWebApplicationSection("system.web/adminUsers"), AdminUsersSection)
        
        ' Bind section to GridView
        bltAdminUsers.DataSource = section.Users
        bltAdminUsers.DataBind()
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show AdminUsersSection</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <h1>Administrators</h1>
    <asp:BulletedList
        id="bltAdminUsers"
        DataTextField="Name"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
