<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    public string SearchString
    {
        get { return txtSearch.Text; }
    }

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Button Search Typed</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblSearch"
        Text="Search:"
        Runat="server" />
    <asp:TextBox
        id="txtSearch"
        Runat="server" />
    <asp:Button
        id="btnSearch"
        Text="Go!"
        PostBackUrl="ButtonSearchResultsTyped.aspx"
        Runat="server" />
    </div>
    </form>
</body>
</html>
