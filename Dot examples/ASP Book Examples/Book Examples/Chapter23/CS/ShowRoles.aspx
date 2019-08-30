<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    void Page_Load()
    {
        // If user is not authenticated, redirect to Login page
        if (!Request.IsAuthenticated)
        {
            FormsAuthentication.RedirectToLoginPage();
            Response.End();
        }
        // Create two roles
        if (!Roles.RoleExists("Managers"))
            Roles.CreateRole("Managers");
        if (!Roles.RoleExists("Sales"))
            Roles.CreateRole("Sales");
        
        // Add current user to both roles
        if (!Roles.IsUserInRole("Managers"))
            Roles.AddUserToRole(User.Identity.Name, "Managers");
        if (!Roles.IsUserInRole("Sales"))
            Roles.AddUserToRole(User.Identity.Name, "Sales");
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Roles</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <h1>Your Roles</h1>
    
    <asp:GridView
        id="grdRoles"
        DataSourceID="srcRoles"
        EmptyDataText="You are not a member of any roles"
        GridLines="none"
        Runat="server" />
    
    <asp:ObjectDataSource
        id="srcRoles"
        TypeName="System.Web.Security.Roles"
        SelectMethod="GetRolesForUser"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
