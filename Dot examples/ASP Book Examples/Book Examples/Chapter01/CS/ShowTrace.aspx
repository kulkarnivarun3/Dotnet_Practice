<%@ Page Language="C#" Trace="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        Label1.Text = "Hello World!";
        Calendar1.TodaysDate = DateTime.Now;
    }
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Trace</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:Label
        id="Label1"
        Runat="server" />
    <asp:Calendar
        id="Calendar1"
        TodayDayStyle-BackColor="Yellow"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
