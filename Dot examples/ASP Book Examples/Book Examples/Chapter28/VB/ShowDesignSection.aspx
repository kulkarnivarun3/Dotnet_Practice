<%@ Page Language="VB" debug="true"%>
<%@ Import Namespace="AspNetUnleashed" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Drawing" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        ' Get configuration
        Dim section As DesignSection = CType(WebConfigurationManager.GetWebApplicationSection("system.web/design"), DesignSection)

        ' Set Background Color
        htmlBody.Attributes("bgcolor") = ColorTranslator.ToHtml(section.BackColor)
        
        ' Set style sheet
        Dim link As New HtmlLink()
        link.Href = section.StyleSheetUrl
        link.Attributes.Add("rel", "stylesheet")
        link.Attributes.Add("type", "text/css")
        Page.Header.Controls.Add(link)
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Design Section</title>
</head>
<body id="htmlBody" runat="server">
    <form id="form1" runat="server">
    <div>
    
    <h1>Custom Configuration Section Sample</h1>
    
    </div>
    </form>
</body>
</html>
