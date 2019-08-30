<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Windows Roles</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:LoginView
        id="LoginView1"
        Runat="server">
        <RoleGroups>
        <asp:RoleGroup Roles="BUILTIN\Administrators">
            <ContentTemplate>
            <h1>Welcome Administrator!</h1>       
            </ContentTemplate> 
        </asp:RoleGroup>
        </RoleGroups>
        <LoggedInTemplate>
            <h1>Welcome Average User!</h1>
        </LoggedInTemplate>
    </asp:LoginView>
    
    </div>
    </form>
</body>
</html>
