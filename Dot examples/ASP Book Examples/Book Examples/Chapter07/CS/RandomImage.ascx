<%@ Control Language="C#" ClassName="RandomImage" %>
<%@ Import Namespace="System.IO" %>

<script runat="server">

    void Page_Load()
    {
        string imageToDisplay = GetRandomImage();
        imgRandom.ImageUrl = Path.Combine("~/Images", imageToDisplay);
        lblRandom.Text = imageToDisplay;
    }

    private string GetRandomImage()
    {
        Random rnd = new Random();
        string[] images = Directory.GetFiles(MapPath("~/Images"), "*.jpg");
        string imageToDisplay = images[rnd.Next(images.Length)];
        return Path.GetFileName(imageToDisplay);
    }
    
</script>

<asp:Image
    id="imgRandom"
    Width="300px"
    Runat="server" />
<br />    
<asp:Label  
    id="lblRandom"
    Runat="server" />