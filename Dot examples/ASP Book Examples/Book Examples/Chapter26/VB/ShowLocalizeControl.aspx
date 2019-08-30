<%@ Page Language="VB" UICulture="auto" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Localize Control</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Localize
        ID="locBodyText"
        meta:resourceKey="locBodyText"
        Runat="server">
        Here is the page body text
    </asp:Localize>    
    
    <br /><br />
    
    <asp:Literal 
        ID="ltlBodyText" 
        runat="server">
        Here is some literal text
    </asp:Literal>
    
    </div>
    </form>
</body>
</html>
