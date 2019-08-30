<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show BulletedList HyperLinks</title>
</head>
<body>
    <form id="form1" runat="server">

    <asp:BulletedList
        id="blWebsites"
        DisplayMode="HyperLink"
        Target="_blank"
        Runat="server">
        <asp:ListItem 
            Text="Yahoo"
            Value="http://www.Yahoo.com" />
        <asp:ListItem 
            Text="Google"
            Value="http://www.Google.com" />
        <asp:ListItem 
            Text="Deja"
            Value="http://www.Deja.com" />
    </asp:BulletedList>
       
    </form>
</body>
</html>
