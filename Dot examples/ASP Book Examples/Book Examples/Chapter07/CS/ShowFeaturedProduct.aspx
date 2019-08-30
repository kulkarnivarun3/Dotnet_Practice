<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    const string randomFolder = "~/FeaturedProducts";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        string featuredProductPath = GetRandomProductPath();
        Control featuredProduct = Page.LoadControl(featuredProductPath);
        PlaceHolder1.Controls.Add(featuredProduct); 
    }

    private string GetRandomProductPath()
    {
        Random rnd = new Random();
        string[] files = Directory.GetFiles(MapPath(randomFolder), "*.ascx");
        string featuredProductPath = Path.GetFileName(files[rnd.Next(files.Length)]);
        return Path.Combine(randomFolder, featuredProductPath);
    }
    
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
