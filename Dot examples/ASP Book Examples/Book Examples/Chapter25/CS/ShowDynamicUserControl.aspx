<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
    
    void Page_Load()
    {
        // Load the control
        PartialCachingControl cacheMe = (PartialCachingControl)Page.LoadControl("Movies.ascx");

        // Change cache duration to 15 seconds
        cacheMe.CachePolicy.SetExpires(DateTime.Now.AddSeconds(15));
               
        // Add control to page
        PlaceHolder1.Controls.Add(cacheMe);

        // Display control cache duration
        lblCacheDuration.Text = cacheMe.CachePolicy.Duration.ToString();
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Dynamic User Control</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    Cache Duration:
    <asp:Label
        id="lblCacheDuration"
        Runat="server" />    
    <hr />
    
    <asp:PlaceHolder
        id="PlaceHolder1"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
