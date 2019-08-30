<%@ Page Language="VB" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
    
    Sub Page_Load()
        If Not Page.IsPostBack Then
            Dim dir As New DirectoryInfo(MapPath("~/Photos"))
            rptPhotos.DataSource = dir.GetFiles("*.jpg")
            rptPhotos.DataBind()
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .photo
        {
            width:400px;
            background-color:white;
            filter:progid:DXImageTransform.Microsoft.Fade(duration=2);
        }
    </style>
    <script type="text/javascript">
    var photos = new Array();
    window.setInterval(showImage, 5000);
    
    function showImage()
    {
        if (photos.length > 0)
        {
            var index = Math.floor(Math.random() * photos.length);
            var image = document.getElementById('imgPhoto');
            image.src = photos[index];
            if (image.filters)
            {
                image.filters[0].Apply();
                image.filters[0].Play();
            }
        }
    }        
    </script>
    <title>Show Repeater Photos</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>


    <img id="imgPhoto" alt="" class="photo" />
    <script type="text/javascript">
    <asp:Repeater
        id="rptPhotos"
        Runat="server">
        <ItemTemplate>
        <%# Eval("Name", "photos.push('Photos/{0}')") %>
        </ItemTemplate>
    </asp:Repeater>
    showImage();
    </script>
    
    </div>
    </form>
</body>
</html>
