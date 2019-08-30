<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        Dim status As MembershipCreateStatus
        ' Create Bill
        Membership.CreateUser("Bill", "secret_", "bill@somewhere.com", "dog", "rover", True, status)
        ' Create Ted
        Membership.CreateUser("Ted", "secret_", "ted@somewhere.com", "dog", "rover", True, status)
        ' Create Fred
        Membership.CreateUser("Fred", "secret_", "fred@somewhere.com", "dog", "rover", True, status)
        ' Create Administrator Role        
        If Not Roles.RoleExists("Administrator") Then
            Roles.CreateRole("Administrator")
            Roles.AddUserToRole("Bill", "Administrator")
        End If
        ' Create Manager Role
        If Not Roles.RoleExists("Manager") Then
            Roles.CreateRole("Manager")
            Roles.AddUserToRole("Bill", "Manager")
            Roles.AddUserToRole("Ted", "Manager")
        End If
        ' Create Worker Role
        If Not Roles.RoleExists("Worker") Then
            Roles.CreateRole("Worker")
            Roles.AddUserToRole("Fred", "Worker")
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>LoginView Roles</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:LoginStatus
        id="LoginStatus"
        Runat="server" />
    <hr />
    
    <asp:LoginView
        id="LoginView1"
        Runat="server">
        <RoleGroups>
        <asp:RoleGroup Roles="Administrator">
        <ContentTemplate>
        This content is displayed to Administrators.
        </ContentTemplate>
        </asp:RoleGroup>
        <asp:RoleGroup Roles="Manager,Worker">
        <ContentTemplate>
        This content is displayed to Managers
        and Workers.
        </ContentTemplate>
        </asp:RoleGroup>
        </RoleGroups>
    </asp:LoginView>
    
    </div>
    </form>
</body>
</html>
