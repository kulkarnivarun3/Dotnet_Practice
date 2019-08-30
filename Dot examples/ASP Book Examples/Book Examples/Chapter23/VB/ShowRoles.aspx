<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    Sub Page_Load()
        ' If user is not authenticated, redirect to Login page
        If Not Request.IsAuthenticated Then
            FormsAuthentication.RedirectToLoginPage()
            Response.End()
        End If
        
        ' Create two roles
        If Not Roles.RoleExists("Managers") Then
            Roles.CreateRole("Managers")
        End If
        If Not Roles.RoleExists("Sales") Then
            Roles.CreateRole("Sales")
        End If
        
        ' Add current user to both roles
        If Not Roles.IsUserInRole("Managers") Then
            Roles.AddUserToRole(User.Identity.Name, "Managers")
        End If
        If Not Roles.IsUserInRole("Sales") Then
            Roles.AddUserToRole(User.Identity.Name, "Sales")
        End If
    End Sub
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
