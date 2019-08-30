<%@ Page Language="VB" %>
<%@ Register TagPrefix="user" TagName="SharedMovies" Src="~/SharedMovies.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Shared Movies</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <user:SharedMovies
        id="SharedMovies1"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
