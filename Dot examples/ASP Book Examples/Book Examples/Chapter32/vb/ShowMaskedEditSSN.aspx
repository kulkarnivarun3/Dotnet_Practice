<%@ Page Language="VB" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Show Masked Edit Social Security Number</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        
        <asp:Label
            id="lblSSN"
            Text="Social Security Number:"
            AssociatedControlID="txtSSN"
            Runat="server" />
        <asp:TextBox
            id="txtSSN"
            Runat="server" />
        <ajax:MaskedEditExtender
            id="MaskedEditExtender1"
            TargetControlID="txtSSN"
            Mask="9{3}-9{2}-9{4}"
            runat="Server" />

        <br /><br />
        
        <asp:Button
            id="btnSubmit"
            Text="Submit"
            Runat="server" />        

    </div>
    </form>
</body>
</html>
