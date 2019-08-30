<%@ Page Language="C#" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show Filtered TextBox</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <asp:Label
            id="lblNumeric"
            Text="Enter a Number:"
            AssociatedControlID="txtNumeric"
            Runat="server" />
        <br />
        <asp:TextBox
            id="txtNumeric"
            Runat="server" />
        <ajax:FilteredTextBoxExtender
            id="fte1"
            TargetControlID="txtNumeric"
            FilterType="Numbers"
            Runat="server" />

        <br /><br />

        <asp:Label
            id="lblProductCode"
            Text="Enter a Product Code:"
            AssociatedControlID="txtProductCode"
            Runat="server" />
        <br />
        <asp:TextBox
            id="txtProductCode"
            Runat="server" />
        <ajax:FilteredTextBoxExtender
            id="fte2"
            TargetControlID="txtProductCode"
            FilterType="LowercaseLetters,Custom"
            FilterMode="ValidChars"
            ValidChars="_!"
            Runat="server" />
        <br />
        (A product code can contain only lower-case characters,
        underscores, exclamation marks, and no spaces)


    </div>
    </form>
</body>
</html>
