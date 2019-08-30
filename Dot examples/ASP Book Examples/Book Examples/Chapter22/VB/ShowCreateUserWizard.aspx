<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .createUser
        {
            width:350px;
            font:14px Verdana,Sans-Serif;
            background-color:lightblue;
            border:solid 3px black;
            padding:4px;
        }
        .createUser_title
        {
            background-color:darkblue;
            color:white;
            font-weight:bold;
        }
        .createUser_instructions
        {
            font-size:12px;
            text-align:left;
            padding:10px;
        }
        .createUser_button
        {
            border:solid 1px black;
            padding:3px;
        }
    </style>
    <title>Show CreateUserWizard</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:CreateUserWizard
        id="CreateUserWizard1"
        ContinueDestinationPageUrl="~/Default.aspx"
        InstructionText="Please complete the following form
            to register at this Website."
        CompleteSuccessText="Your new account has been
            created. Thank you for registering."    
        CssClass="createUser"
        TitleTextStyle-CssClass="createUser_title"
        InstructionTextStyle-CssClass="createUser_instructions"
        CreateUserButtonStyle-CssClass="createUser_button"
        ContinueButtonStyle-CssClass="createUser_button"
        Runat="server" />
        
    
    </div>
    </form>
</body>
</html>
