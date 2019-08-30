<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        lblPrivateBytes.Text = Cache.EffectivePrivateBytesLimit.ToString("n0");
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Private Bytes Limit</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    Effective Private Bytes Limit:
    <asp:Label
        id="lblPrivateBytes"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
