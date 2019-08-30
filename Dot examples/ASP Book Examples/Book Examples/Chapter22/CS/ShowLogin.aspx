<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .login
        {
            width:250px;
            font:14px Verdana,Sans-Serif;
            background-color:lightblue;
            border:solid 3px black;
            padding:4px;
        }
        .login_title
        {
            background-color:darkblue;
            color:white;
            font-weight:bold;
        }
        .login_instructions
        {
            font-size:12px;
            text-align:left;
            padding:10px;
        }
        .login_button
        {
            border:solid 1px black;
            padding:3px;
        }
    </style>
    <title>Show Login</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:Login
        id="Login1"
        InstructionText="Please log in before 
            accessing the premium section of our Website."
        TitleText="Log In"
        TextLayout="TextOnTop"
        LoginButtonText="Log In"
        DisplayRememberMe="false"
        CssClass="login"
        TitleTextStyle-CssClass="login_title"
        InstructionTextStyle-CssClass="login_instructions"
        LoginButtonStyle-CssClass="login_button"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
