<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .passwordRecovery
        {
            font:14px Verdana,Sans-Serif;
            background-color:lightblue;
            border:solid 3px black;
            padding:4px;
        }
        .passwordRecovery_title
        {
            background-color:darkblue;
            color:white;
            font-weight:bold;
        }
        .passwordRecovery_instructions
        {
            font-size:12px;
            text-align:left;
            padding:10px;
        }
        .passwordRecovery_button
        {
            border:solid 1px black;
            padding:3px;
        }
    </style>
    <title>Show PasswordRecovery</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:PasswordRecovery
        id="PasswordRecovery1"
        CssClass="passwordRecovery"
        TitleTextStyle-CssClass="passwordRecovery_title"
        InstructionTextStyle-CssClass="passwordRecovery_instructions"
        SubmitButtonStyle-CssClass="passwordRecovery_button"
        Runat="server">
        <MailDefinition
            From="Admin@YourSite.com"
            Subject="Password Reminder" />
    </asp:PasswordRecovery>    
    
    </div>
    </form>
</body>
</html>
