<%@ Page Language="C#" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show Masked Edit</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <asp:Label
            id="lblTitle"
            Text="Title:"
            AssociatedControlID="txtTitle"
            Runat="server" />
        <asp:TextBox
            id="txtTitle"
            Runat="server" />
            
        <br /><br />
        
        <asp:Label
            id="lblDateReleased"
            Text="Date Released:"
            AssociatedControlID="txtDateReleased"
            Runat="server" />
        <asp:TextBox
            id="txtDateReleased"
            Runat="server" />
        <ajax:MaskedEditExtender
            id="me1"
            TargetControlID="txtDateReleased"
            Mask="99/99/9999"
            MaskType="Date"
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
