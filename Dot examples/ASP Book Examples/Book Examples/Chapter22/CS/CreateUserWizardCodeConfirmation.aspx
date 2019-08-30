<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void CreateUserWizard1_SendingMail(object sender, MailMessageEventArgs e)
    {
        MembershipUser user = Membership.GetUser(CreateUserWizard1.UserName);
        string code = user.ProviderUserKey.ToString();
        e.Message.Body = e.Message.Body.Replace("<%ConfirmationCode%>", code);
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>CreateUserWizard Code Confirmation</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
    <asp:CreateUserWizard
        id="CreateUserWizard1"
        CompleteSuccessText="A confirmation email
            containing your new password has been
            sent to your email address."    
        DisableCreatedUser="true"
        ContinueDestinationPageUrl="~/ConfirmCode.aspx"
        OnSendingMail="CreateUserWizard1_SendingMail"
        Runat="server">
        <MailDefinition
            From="Admin@YourSite.com"
            BodyFileName="CodeConfirmation.htm"
            IsBodyHtml="true"
            Subject="Registration Confirmation" />
    </asp:CreateUserWizard>
    
    </div>
    </form>
</body>
</html>
