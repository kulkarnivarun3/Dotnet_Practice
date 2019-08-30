<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show SetFocusOnError</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
    <asp:Label
        id="lblFirstName"
        Text="First Name"
        AssociatedControlID="txtFirstName"
        Runat="server" />
    <br />    
    <asp:TextBox
        id="txtFirstName"
        Runat="server" />
    <asp:RequiredFieldValidator
        id="reqFirstName"
        ControlToValidate="txtFirstName"
        Text="(Required)"
        SetFocusOnError="true" 
        Runat="server" />   
     
    <br /><br />
        
    <asp:Label
        id="lblLastName"
        Text="Last Name"
        AssociatedControlID="txtLastName"
        Runat="server" />
    <br />    
    <asp:TextBox
        id="txtLastname"
        Runat="server" />
    <asp:RequiredFieldValidator
        id="reqLastName"
        ControlToValidate="txtLastName"
        Text="(Required)" 
        SetFocusOnError="true"
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
