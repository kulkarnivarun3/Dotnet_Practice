<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    /// <summary>
    /// Bind photos to Repeater
    /// </summary>
    void Page_Load()
    {
        if (!Page.IsPostBack)
        {
            Repeater1.DataSource = GetPhotos();
            Repeater1.DataBind(); 
        }   
    }
    
    /// <summary>
    /// Get list of photos from Photo folder
    /// </summary>
    public List<String> GetPhotos()
    {
        List<string> photos = new List<string>();
        string photoPath = MapPath("~/Photos");
        string[] files = Directory.GetFiles(photoPath);
        foreach (string photo in files)
            photos.Add("~/Photos/" + Path.GetFileName(photo));
        return photos;    
    }
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Photos</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:Repeater
        id="Repeater1"
        runat="server">
        <ItemTemplate>
            <asp:Image
                id="Image1"
                Width="200px"
                ImageUrl='<%# Container.DataItem %>'
                Runat="server" />
        </ItemTemplate>
    </asp:Repeater>    

    </div>
    </form>
</body>
</html>
