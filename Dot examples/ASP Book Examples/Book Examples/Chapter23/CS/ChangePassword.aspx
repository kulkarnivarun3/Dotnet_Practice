<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Change Password</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:ChangePassword
        id="ChangePassword1"
        DisplayUserName="true"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
