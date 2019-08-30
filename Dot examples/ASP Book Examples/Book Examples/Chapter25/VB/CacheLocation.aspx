<%@ Page Language="VB" %>
<%@ OutputCache Duration="3600" VaryByParam="none" Location="Client" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        Dim rnd As New Random()
        lblRandom.Text = rnd.Next(10).ToString()
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Cache Location</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <%= DateTime.Now.ToString("T") %>
    <hr />
    
    Your random number is: 
    <asp:Label  
        id="lblRandom"
        Runat="server" />
    
    <br /><br />
    <a href="CacheLocation.aspx">Request Page</a>
    
    </div>
    </form>
</body>
</html>
