<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show ValidationSummary</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:ValidationSummary
        id="ValidationSummary1"
        Runat="server" />
    
    <asp:Label
        id="lblFirstName"
        Text="First Name:"
        AssociatedControlID="txtFirstName"
        Runat="server" />
    <br />
    <asp:TextBox
        id="txtFirstName"
        Runat="server" />
    <asp:RequiredFieldValidator
        id="reqFirstName"
        Text="(Required)"
        ErrorMessage="First Name is required"
        ControlToValidate="txtFirstName"
        Runat="server" />       
    
    <br /><br />
        
    <asp:Label
        id="lblLastName"
        Text="Last Name:"
        AssociatedControlID="txtLastName"
        Runat="server" />
    <br />
    <asp:TextBox
        id="txtLastName"
        Runat="server" />
    <asp:RequiredFieldValidator
        id="reqLastName"
        Text="(Required)"
        ErrorMessage="Last Name is required"
        ControlToValidate="txtLastName"
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
