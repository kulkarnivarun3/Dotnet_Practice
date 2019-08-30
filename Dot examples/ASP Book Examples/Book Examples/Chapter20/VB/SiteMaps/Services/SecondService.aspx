<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Private Sub Page_Load()
        Dim meta As HtmlMeta = New HtmlMeta()
        meta.Name = "Description"
        meta.Content = SiteMap.CurrentNode("metaDescription")
        head1.Controls.Add(meta)
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="head1" runat="server">
    <title>Second Service</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <h1>The Second Service</h1>
    
    </div>
    </form>
</body>
</html>
