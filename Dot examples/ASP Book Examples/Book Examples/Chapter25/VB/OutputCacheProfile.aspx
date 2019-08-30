<%@ Page Language="VB" %>
<%@ OutputCache CacheProfile="Cache1Hour" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Output Cache Profile</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <%= DateTime.Now.ToString("T") %>
    
    </div>
    </form>
</body>
</html>
