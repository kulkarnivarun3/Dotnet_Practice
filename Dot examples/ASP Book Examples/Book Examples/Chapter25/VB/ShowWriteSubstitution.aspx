<%@ Page Language="VB" %>
<%@ OutputCache Duration="15" VaryByParam="none" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Public Shared Function GetTime(ByVal context As HttpContext) As String
        Return DateTime.Now.ToString("T")
    End Function
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
    <% Response.WriteSubstitution(AddressOf GetTime)%>
    
    </div>
    </form>
</body>
</html>
