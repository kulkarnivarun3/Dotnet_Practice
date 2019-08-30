<%@ Page Language="C#" Theme="Simple2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Show Named Skin</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:TextBox
        id="txtFirstName"
        SkinID="DashedTextBox"
        Runat="server" />
    
    <br /><br />
    
    <asp:TextBox
        id="txtLastName"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
