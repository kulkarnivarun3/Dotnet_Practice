<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        MembershipCreateStatus status;
        // Create Bill
        Membership.CreateUser("Bill","secret_","bill@somewhere.com","dog","rover",true,out status);
        // Create Ted
        Membership.CreateUser("Ted", "secret_", "ted@somewhere.com", "dog", "rover", true,out status);
        // Create Fred
        Membership.CreateUser("Fred", "secret_", "fred@somewhere.com", "dog", "rover", true, out status);
        // Create Administrator Role        
        if (!Roles.RoleExists("Administrator"))
        {
            Roles.CreateRole("Administrator");
            Roles.AddUserToRole("Bill", "Administrator");
        }
        // Create Manager Role
        if (!Roles.RoleExists("Manager"))
        {
            Roles.CreateRole("Manager");
            Roles.AddUserToRole("Bill", "Manager");
            Roles.AddUserToRole("Ted", "Manager");
        }
        // Create Worker Role
        if (!Roles.RoleExists("Worker"))
        {
            Roles.CreateRole("Worker");
            Roles.AddUserToRole("Fred", "Worker");
        }
    }
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
