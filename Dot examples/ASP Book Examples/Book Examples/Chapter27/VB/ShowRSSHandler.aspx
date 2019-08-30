<%@ Page Language="VB" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        Dim pagePath As String = Request.Url.OriginalString
        Dim rssPath As String = Path.ChangeExtension(pagePath, ".rss")
        srcRSS.DataFile = rssPath
    End Sub
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
