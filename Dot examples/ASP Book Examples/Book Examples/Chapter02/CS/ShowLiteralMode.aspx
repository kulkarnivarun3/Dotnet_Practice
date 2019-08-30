<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Literal Mode</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Literal
        id="ltlFirst"
        Mode="PassThrough"
        Text="<hr />"
        Runat="server" />

    <br /><br />

    <asp:Literal
        id="ltlSecond"
        Mode="Encode"
        Text="<hr />"
        Runat="server" />

    <br /><br />

    <asp:Literal
        id="ltlThird"
        Mode="Transform"
        Text="<hr />"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
