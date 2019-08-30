<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            font:12px Arial,Sans-Serif;
        }
        h1
        {
            font:bold 16px Arial,Sans-Serif;
            color:DarkGray;
        }
    </style>
    <title>PasswordRecovery Template</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:PasswordRecovery
        id="PasswordRecovery1"
        Runat="server">
        <MailDefinition
            From="Admin@YourSite.com"
            Subject="Password Reminder"
            BodyFileName="PasswordRecovery.txt" />
        <UserNameTemplate>
        <h1>User Name</h1>
        <asp:Label
            id="FailureText"
            EnableViewState="false"
            ForeColor="Red"
            Runat="server" />
        <br />
        <asp:Label
            id="lblUserName"
            Text="Enter your user name:"
            AssociatedControlID="UserName"
            Runat="server" />
        <br />
        <asp:TextBox
            id="UserName"
            Runat="server" />
        <br />
        <asp:Button
            id="btnSubmit"
            Text="Next"
            CommandName="Submit"
            Runat="server" />    
        </UserNameTemplate>    
        <QuestionTemplate>
        <h1>Security Question</h1>
        <asp:Label
            id="FailureText"
            EnableViewState="false"
            ForeColor="Red"
            Runat="server" />
        <br />
        <asp:Label
            id="Question"
            Text="Enter your user name:"
            AssociatedControlID="Answer"
            Runat="server" />
        <br />
        <asp:TextBox
            id="Answer"
            Runat="server" />
        <br />
        <asp:Button
            id="btnSubmit"
            Text="Next"
            CommandName="Submit"
            Runat="server" />    
        </QuestionTemplate>
        <SuccessTemplate>
        <h1>Success</h1>
        An email has been sent to your registered
        email account that contains your user name
        and password.
        </SuccessTemplate>
    </asp:PasswordRecovery>
    
    </div>
    </form>
</body>
</html>
