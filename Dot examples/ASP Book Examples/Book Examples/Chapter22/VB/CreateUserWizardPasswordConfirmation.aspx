<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>CreateUserWizard Password Confirmation</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:CreateUserWizard
        id="CreateUserWizard1"
        CompleteSuccessText="A confirmation email
            containing your new password has been
            sent to your email address."    
        AutoGeneratePassword="true"
        LoginCreatedUser="false"
        ContinueDestinationPageUrl="~/Login.aspx"
        Runat="server">
        <MailDefinition
            From="Admin@YourSite.com"
            BodyFileName="PasswordConfirmation.htm"
            IsBodyHtml="true"
            Subject="Registration Confirmation" />
    </asp:CreateUserWizard>
    
    </div>
    </form>
</body>
</html>
