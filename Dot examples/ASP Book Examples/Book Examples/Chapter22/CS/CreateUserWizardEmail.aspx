<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>CreateUserWizard Email</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:CreateUserWizard
        id="CreateUserWizard1"
        Runat="server">
        <MailDefinition
            BodyFileName="Register.txt"
            Subject="Registration Confirmation"
            From="Admin@YourSite.com" />
    </asp:CreateUserWizard>
    
    </div>
    </form>
</body>
</html>
