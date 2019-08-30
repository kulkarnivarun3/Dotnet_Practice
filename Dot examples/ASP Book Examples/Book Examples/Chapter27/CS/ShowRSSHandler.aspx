<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        string pagePath = Request.Url.OriginalString;
        string rssPath = Path.ChangeExtension(pagePath, ".rss");
        srcRSS.DataFile = rssPath;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show RSS Handler</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdRSS"
        DataSourceID="srcRSS"
        AutoGenerateColumns="false"
        Runat="server">
        <Columns>
        <asp:TemplateField HeaderText="Articles">
        <ItemTemplate>
            <asp:HyperLink
                id="lnkRSS"
                Text='<%# XPath("title") %>'
                NavigateUrl='<%# XPath("link") %>'
                Runat="server" />
        </ItemTemplate>
        </asp:TemplateField>
        </Columns>
    </asp:GridView>    
    
    <asp:XmlDataSource
        id="srcRSS"
        XPath="//item"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
