<%@ Page Language="vb" %>
<%@ Register TagPrefix="custom" Namespace="MyControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show Help Extender</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <asp:Label
            id="lblFirstName"
            Text="First Name:"
            AssociatedControlID="txtFirstName"
            Runat="server" />
        <asp:TextBox
            id="txtFirstName"
            Runat="server" />
        <custom:HelpExtender
            id="he1"
            TargetControlID="txtFirstName"
            Text="Enter your first name."
            Runat="server" />
            
        <br /><br />

        <asp:Label
            id="lblLastName"
            Text="Last Name:"
            AssociatedControlID="txtLastName"
            Runat="server" />
        <asp:TextBox
            id="txtLastName"
            Runat="server" />
        <custom:HelpExtender
            id="he2"
            TargetControlID="txtLastName"
            Text="Enter your last name."
            Runat="server" />

    </div>
    </form>
</body>
</html>
