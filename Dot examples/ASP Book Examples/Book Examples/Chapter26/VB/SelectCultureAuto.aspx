<%@ Page Language="VB" Culture="auto:en-US" UICulture="auto:en-US"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    Sub Page_PreRender()
        lblDate.Text = DateTime.Now.ToString("D")
        lblPrice.Text = (512.33D).ToString("c")
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Select Culture Auto</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    Today's date is:
    <br />
    <asp:Label
        id="lblDate"
        Runat="server" />
    
    <br /><br />
    
    The price of the product is:
    <br />
    <asp:Label
        id="lblPrice"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
