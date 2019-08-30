<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .changePassword
        {
            font:14px Verdana,Sans-Serif;
            background-color:lightblue;
            border:solid 3px black;
            padding:4px;
        }
        .changePassword_title
        {
            background-color:darkblue;
            color:white;
            font-weight:bold;
        }
        .changePassword_instructions
        {
            font-size:12px;
            text-align:left;
            padding:10px;
        }
        .changePassword_button
        {
            border:solid 1px black;
            padding:3px;
        }
    </style>
    <title>Show ChangePassword</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:LoginName ID="LoginName1" runat="server" />
    
    <asp:ChangePassword
        id="ChangePassword1"
        InstructionText="Complete this form to create
            a new password."
        DisplayUserName="true"
        ContinueDestinationPageUrl="~/Default.aspx"
        CancelDestinationPageUrl="~/Default.aspx"
        CssClass="changePassword"        
        TitleTextStyle-CssClass="changePassword_title"
        InstructionTextStyle-CssClass="changePassword_instructions"
        ChangePasswordButtonStyle-CssClass="changePassword_button"
        CancelButtonStyle-CssClass="changePassword_button"
        ContinueButtonStyle-CssClass="changePassword_button"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
