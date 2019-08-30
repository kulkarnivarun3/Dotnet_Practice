<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        lblServerTime.Text = DateTime.Now.ToString();
    }
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>First Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    Welcome to ASP.NET 3.5! The current date and time is:
    
    <asp:Label
        id="lblServerTime"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
