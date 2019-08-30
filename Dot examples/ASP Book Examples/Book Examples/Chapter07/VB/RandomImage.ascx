<%@ Control Language="VB" ClassName="RandomImage" %>
<%@ Import Namespace="System.IO" %>

<script runat="server">
 
    Private Sub Page_Load()
        Dim imageToDisplay As String = GetRandomImage()
        imgRandom.ImageUrl = Path.Combine("~/Images", imageToDisplay)
        lblRandom.Text = imageToDisplay
    End Sub
 
    Private Function GetRandomImage() As String
        Dim rnd As New Random()
        Dim images() As String = Directory.GetFiles(MapPath("~/Images"), "*.jpg")
        Dim imageToDisplay As String = images(rnd.Next(images.Length))
        Return Path.GetFileName(imageToDisplay)
    End Function
</script>

<asp:Image
    id="imgRandom"
    Width="300px"
    Runat="server" />
<br />    
<asp:Label  
    id="lblRandom"
    Runat="server" />