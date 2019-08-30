﻿<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Init()
    {
        btn.Click += delegate(object sender, EventArgs e) 
                        {
                            lblResult.Text = DateTime.Now.ToString();
                        }; 
    }

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Anonymous Method</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Button 
        id="btn"
        Text="Go!"
        Runat="server" />
    
    <asp:Label
        id="lblResult"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
