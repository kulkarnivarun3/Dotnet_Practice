<%@ Page Language="VB" %>
<%@ Register TagPrefix="user" TagName="SlidingUserCache" Src="~/SlidingUserCache.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Sliding User Cache</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    Page Time:
    <%= DateTime.Now.ToString("T") %>
    <hr />
    <user:SlidingUserCache
        id="SlidingUserCache"
        Runat="Server" />
    
    </div>
    </form>
</body>
</html>
