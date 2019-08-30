<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    [System.Web.Services.WebMethod]
    public static string GetSecretMessage()
    {
        return "Time is a fish";
    }

</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show Login</title>
    <script type="text/javascript">
    
      function pageLoad() 
      {
        $addHandler( $get("btnLogin"), "click", login);
      }
      
      function login()
      {
        Sys.Services.AuthenticationService.login
            (
                $get("txtUserName").value,
                $get("txtPassword").value,
                false,
                null,
                null,
                loginSuccess,
                loginFail
            );
      }
    
      function loginSuccess(isAuthenticated)
      {
        if (isAuthenticated)
            PageMethods.GetSecretMessage(getSecretMessageSuccess);
        else
            alert( "Log in failed" );
      }
    
      function loginFail()
      {
            alert( "Log in failed" );      
      }
    
      function getSecretMessageSuccess(message)
      {
        $get("spanMessage").innerHTML = message;
      }
        
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager 
        ID="ScriptManager1" 
        EnablePageMethods="true"
        runat="server" />
    
    <fieldset>
    <legend>Login</legend>
    
        <label for="txtUserName">User Name:</label>
        <input id="txtUserName" />
    
        <br /><br />
    
        <label for="txtUserName">Password:</label>
        <input id="txtPassword" type="password" />
    
        <br /><br />
        <input id="btnLogin" type="button" value="Login" />
    
    </fieldset>

    The secret message is:
    <span id="spanMessage"></span>
    
    </form>
</body>
</html>
