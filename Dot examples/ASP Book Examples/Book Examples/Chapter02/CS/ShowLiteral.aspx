<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    void Page_Load()
    {
        ltlTitle.Text = DateTime.Now.ToString("D");
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title><asp:Literal id="ltlTitle" Runat="Server" /></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <h1>Look in the title bar</h1>
    
    </div>
    </form>
</body>
</html>
