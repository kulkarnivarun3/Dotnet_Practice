<%@ Page Language="VB" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show ContentRotator</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <custom:ContentRotator
        id="ContentRotator1"
        Runat="server">
        <custom:Content
            id="Content1"
            Runat="server">
            First Content Item    
        </custom:Content>    
        <custom:Content
            id="Content2"
            Runat="server">
            Second Content Item
            <asp:Calendar
                id="Calendar1"
                Runat="server" />    
        </custom:Content>    
        <custom:Content
            id="Content3"
            Runat="server">
            Third Content Item    
        </custom:Content>    
    </custom:ContentRotator>
    
    </div>
    </form>
</body>
</html>
