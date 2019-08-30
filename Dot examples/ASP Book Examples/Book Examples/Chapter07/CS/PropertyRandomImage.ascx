<%@ Control Language="C#" ClassName="PropertyRandomImage" %>
<%@ Import Namespace="System.IO" %>
<script runat="server">

    private string _imageFolderPath = "~/Images"; 

    public string ImageFolderPath
    {
        get { return _imageFolderPath; }
        set { _imageFolderPath = value; }
    }

    void Page_Load()
    {
        string imageToDisplay = GetRandomImage();
        imgRandom.ImageUrl = Path.Combine(_imageFolderPath, imageToDisplay);
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