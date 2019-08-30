<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        Response.Cache.SetCacheability(HttpCacheability.Public)
        Response.Cache.SetExpires(DateTime.Now.AddSeconds(15))
        Response.Cache.SetMaxAge(TimeSpan.FromSeconds(15))
        Response.Cache.SetValidUntilExpires(True)
        Response.Cache.SetLastModified(DateTime.Now)
        Response.Cache.SetOmitVaryStar(True)
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Program OutputCache</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <%= DateTime.Now.ToString("T") %>
    
    <br /><br />
    <a href="ProgramOutputCache.aspx">Request this Page</a>
    
    </div>
    </form>
</body>
</html>
