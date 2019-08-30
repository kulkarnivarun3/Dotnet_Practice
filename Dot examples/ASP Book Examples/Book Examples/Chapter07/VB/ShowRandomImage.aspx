<%@ Page Language="VB" %>
<%@ Register TagPrefix="user" TagName="RandomImage" Src="~/RandomImage.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show RandomImage</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <user:RandomImage
        ID="RandomImage1"
        Runat="server" />
        
    </div>
    </form>
</body>
</html>
