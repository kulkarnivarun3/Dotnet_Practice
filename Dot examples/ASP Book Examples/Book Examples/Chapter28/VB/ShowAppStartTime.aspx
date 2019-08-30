<%@ Page Language="VB" %>
<%@ Import Namespace="System.Web.Hosting" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        Dim appStart As DateTime = CType(Application("AppStart"), DateTime)
        lblAppStart.Text = appStart.ToString()
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Application Start Time</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     
    Application Start Time:
    <asp:Label
        id="lblAppStart"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
