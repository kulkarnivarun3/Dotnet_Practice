<%@ Page Language="C#" %>
<%@ PreviousPageType VirtualPath="~/ShowAdvancedCheckBox.aspx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        if (this.PreviousPage != null)
        {
            lblProductName.Text = this.PreviousPage.ProductName;
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Advanced Options</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    Product Name:
    <asp:Label
        id="lblProductName"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
