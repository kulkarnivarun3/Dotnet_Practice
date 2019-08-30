<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Compare Values</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label  
        id="lblStartDate"
        Text="Start Date:"
        Runat="server" />
    <asp:TextBox
        id="txtStartDate"
        Runat="server" />
        
    <br /><br />    
    
    <asp:Label  
        id="lblEndDate"
        Text="End Date:"
        Runat="server" />
    <asp:TextBox
        id="txtEndDate"
        Runat="server" />
    <asp:CompareValidator
        id="cmpDate"
        Text="(End date must be greater than start date)"
        ControlToValidate="txtEndDate"
        ControlToCompare="txtStartDate"
        Type="Date"
        Operator="GreaterThan"
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
