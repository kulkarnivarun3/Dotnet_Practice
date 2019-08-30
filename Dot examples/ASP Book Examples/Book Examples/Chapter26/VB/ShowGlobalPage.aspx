<%@ Page Language="VB" UICulture="auto" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>
    <asp:Literal 
        id="ltlTitle" 
        Text="<%$ Resources:Site,Title %>" 
        Runat="Server" />
    </title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <br />Page Content
    <br />Page Content
    <br />Page Content
    <br />Page Content

    <hr />
    <asp:Literal
        id="ltlCopyright"
        Text="<%$ Resources:Site,Copyright %>"    
        Runat="Server" />
        
    </div>
    </form>
</body>
</html>
