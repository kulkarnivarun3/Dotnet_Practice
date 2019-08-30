<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show Roles</title>
    <script type="text/javascript">
    
      function pageLoad() 
      {
        Sys.Services.AuthenticationService.login
            (
                "Steve",
                "secret#",
                false,
                null,
                null,
                loginSuccess
            );
      }
      
      function loginSuccess(isAuthenticated)
      {
        if (isAuthenticated)
            loadRoles();
        else
            alert("Log in failed!");
      }
    
      function loadRoles()
      {
        Sys.Services.RoleService.load(loadRolesSuccess, loadRolesFail);
      }
    
      function loadRolesSuccess()
      {
        var isPlumber = Sys.Services.RoleService.isUserInRole("Plumber");
        $get("spanPlumber").innerHTML = isPlumber;
            
        var isPainter = Sys.Services.RoleService.isUserInRole("Painter");
        $get("spanPainter").innerHTML = isPainter;
      }
        
      function loadRolesFail(error)
      {
        alert("Could not load roles!");
      }
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        Is Plumber: <span id="spanPlumber"></span>

        <br /><br />
        
        Is Painter: <span id="spanPainter"></span>

    </div>
    </form>
</body>
</html>
