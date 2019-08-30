<%@ Page Language="VB" Theme="Simple4" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show EnableTheming</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Calendar
        id="Calendar1"
        Runat="server" />
        
    <br /><br />
    
    <asp:Calendar
        id="Calendar2"
        EnableTheming="false"
        Runat="server" />    
    
    </div>
    </form>
</body>
</html>
