<%@ Page Language="VB" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Length Validator</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblComments"
        Text="Comments:"
        AssociatedControlID="txtComments"
        Runat="server" />
    <br />
    <asp:TextBox
        id="txtComments"
        TextMode="MultiLine"
        Columns="30"
        Rows="2"
        Runat="server" />
    <custom:LengthValidator
        id="valComments"
        ControlToValidate="txtComments"
        Text="(Must be less than 10 characters)"
        MaximumLength="10"
        Runat="server" />
    
    <br /><br />
    
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
