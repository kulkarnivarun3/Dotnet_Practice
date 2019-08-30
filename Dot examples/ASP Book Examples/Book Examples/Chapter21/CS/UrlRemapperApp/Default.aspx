<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Default</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <h1>The Default Page</h1>
    
    You requested the page:
    
    <blockquote>
    <%= Request.RawUrl %>
    </blockquote>
    
    which was remapped to:
    
    <blockquote>
    <%= Request.Path %>
    </blockquote>
    
    </div>
    </form>
</body>
</html>
