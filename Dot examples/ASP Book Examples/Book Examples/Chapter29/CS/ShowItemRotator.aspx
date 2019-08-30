<%@ Page Language="C#" Trace="true" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show ItemRotator</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <custom:ItemRotator
        id="ItemRotator1"
        Runat="server">
        <custom:item ID="Item1" runat="server">
            First Item
        </custom:item>
        <custom:item ID="Item2" runat="server">
            Second Item
            <asp:Calendar
                id="Calendar1"
                Runat="server" />
        </custom:item>
        <custom:item ID="Item3" runat="server">
            Third Item
        </custom:item>
    </custom:ItemRotator>
        
    </div>
    </form>
</body>
</html>
