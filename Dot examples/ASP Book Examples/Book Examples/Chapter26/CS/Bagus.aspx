<%@ Page Language="C#" Culture="id-ID" UICulture="id-ID" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    void Page_Load()
    {
        lblDate.Text = DateTime.Now.ToString("D");
        lblPrice.Text = (512.33m).ToString("c");
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Bagus</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    Today's date is:
    <br />
    <asp:Label
        id="lblDate"
        Runat="server" />
    
    <hr />
    The price of the product is:
    <br />
    <asp:Label
        id="lblPrice"
        Runat="server" />

    </div>
    </form>
</body>
</html>
