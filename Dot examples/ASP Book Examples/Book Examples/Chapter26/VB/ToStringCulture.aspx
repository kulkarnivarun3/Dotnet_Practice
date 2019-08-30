<%@ Page Language="VB" %>
<%@ Import Namespace="System.Globalization" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    Private  Sub Page_Load()
        ' Get German Culture Info
        Dim gCulture As New CultureInfo("de-DE") 
 
        ' Use culture when formatting strings
        lblGermanDate.Text = DateTime.Now.ToString("D", gCulture)
        lblGermanPrice.Text = (512.33D).ToString("c", gCulture)
 
        ' Get Indonesian Culture Info
        Dim iCulture As New CultureInfo("id-ID") 
 
        ' Use culture when formatting strings
        lblIndonesianDate.Text = DateTime.Now.ToString("D", iCulture)
        lblIndonesianPrice.Text = (512.33D).ToString("c", iCulture)
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>ToString Culture</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <h1>German</h1>
    
    Today's date is:
    <br />
    <asp:Label
        id="lblGermanDate"
        Runat="server" />
    
    <br /><br />
    
    The price of the product is:
    <br />
    <asp:Label
        id="lblGermanPrice"
        Runat="server" />

    
    <h1>Indonesian</h1>
    
    Today's date is:
    <br />
    <asp:Label
        id="lblIndonesianDate"
        Runat="server" />
    
    <br /><br />
    
    The price of the product is:
    <br />
    <asp:Label
        id="lblIndonesianPrice"
        Runat="server" />
    
    
    </div>
    </form>
</body>
</html>
