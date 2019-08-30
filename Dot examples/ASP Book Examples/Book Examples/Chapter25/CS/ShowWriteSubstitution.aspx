<%@ Page Language="C#" %>
<%@ OutputCache Duration="15" VaryByParam="none" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    public static string GetTime(HttpContext context)
    {
        return DateTime.Now.ToString("T");
    } 
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show WriteSubstitution</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    The cached time is: <%= DateTime.Now.ToString("T") %>
    <hr />
    The substitution time is:
    <% Response.WriteSubstitution(GetTime); %>
    
    </div>
    </form>
</body>
</html>
