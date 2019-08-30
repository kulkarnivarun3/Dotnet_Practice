<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        // Get current value of cookie
        int counter = 0;
        if (Request.Cookies["counter"] != null)
            counter = Int32.Parse(Request.Cookies["counter"].Value);
        
        // Increment counter
        counter++;
        
        // Add persistent cookie to browser
        Response.Cookies["counter"].Value = counter.ToString();
        Response.Cookies["counter"].Expires = DateTime.Now.AddYears(2);
        
        // Display value of counter cookie
        lblCounter.Text = counter.ToString();
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Set Persistent Cookie</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    You have visited this page
    <asp:Label  
        id="lblCounter"
        Runat="server" />
    times!
    
    </div>
    </form>
</body>
</html>
