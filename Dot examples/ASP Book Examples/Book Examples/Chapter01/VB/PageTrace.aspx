<%@ Page Language="VB" Trace="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        For counter As Integer = 0 To 9
            ListBox1.Items.Add("item " & counter.ToString())
            Trace.Warn("counter=" & counter.ToString())
        Next
    End Sub
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Page Trace</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:ListBox
        id="ListBox1"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
