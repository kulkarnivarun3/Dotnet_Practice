<%@ Page Language="VB" %>
<%@ Register TagPrefix="user" TagName="PropertyRandomImage" Src="~/PropertyRandomImage.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Protected  Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        PropertyRandomImage1.ImageFolderPath = "~/Images2"
    End Sub

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Programmatic</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <user:PropertyRandomImage
        ID="PropertyRandomImage1"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
