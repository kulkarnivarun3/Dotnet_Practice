<%@ Page Language="VB" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Const randomFolder As String = "~/FeaturedProducts"
 
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        Dim featuredProductPath As String = GetRandomProductPath()
        Dim featuredProduct As Control = Page.LoadControl(featuredProductPath)
        PlaceHolder1.Controls.Add(featuredProduct)
    End Sub
 
    Private Function GetRandomProductPath() As String
        Dim rnd As New Random()
        Dim files() As String =  Directory.GetFiles(MapPath(randomFolder),"*.ascx") 
        Dim featuredProductPath As String =  Path.GetFileName(files(rnd.Next(files.Length))) 
        Return Path.Combine(randomFolder,featuredProductPath)
    End Function

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Featured Products</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:PlaceHolder
        id="PlaceHolder1"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
