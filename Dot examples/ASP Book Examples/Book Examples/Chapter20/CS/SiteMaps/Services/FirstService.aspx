<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    void Page_Load()
    {
        HtmlMeta meta = new HtmlMeta();
        meta.Name = "Description"; 
        meta.Content = SiteMap.CurrentNode["metaDescription"];
        head1.Controls.Add(meta);
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="head1" runat="server">
    <title>First Service</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <h1>The First Service</h1>
    
    </div>
    </form>
</body>
</html>
