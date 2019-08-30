<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Data Type Check</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblBirthDate"
        Text="Birth Date:"
        AssociatedControlID="txtBirthDate"
        Runat="server" />
    <asp:TextBox
        id="txtBirthDate"
        Runat="server" />
    <asp:CompareValidator
        id="cmpBirthDate"
        Text="(Invalid Date)"
        ControlToValidate="txtBirthDate"
        Type="Date"
        Operator="DataTypeCheck"
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
