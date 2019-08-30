<%@ Page Language="VB" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    sub Page_Load()
        Dim photos as new List(Of string)()
        photos.Add( "~/Images/Ascent.jpg" )
        photos.Add( "~/Images/Autumn.jpg" )
        photos.Add( "~/Images/Azul.jpg" )
        photos.Add( "~/Images/Home.jpg" )
        photos.Add( "~/Images/Peace.jpg" )
        photos.Add( "~/Images/Stonehenge.jpg" )
        photos.Add( "~/Images/Tulips.jpg" )
    
        lstPhotos.DataSource = photos
        lstPhotos.DataBind()
    end sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Photo Gallery</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:ListView 
        ID="lstPhotos"
        GroupItemCount="3"
        runat="server">
        <LayoutTemplate>
            <asp:Placeholder 
                id="groupPlaceholder"
                runat="server" />
        </LayoutTemplate>
        <GroupTemplate>
            <div>
            <asp:Placeholder 
                id="itemPlaceholder" 
                runat="server" />
            </div>
        </GroupTemplate>
        <ItemTemplate>
            <asp:Image
                id="imgPhoto"
                ImageUrl='<%# Container.DataItem %>'
                Width="200px"
                Runat="server" />
        </ItemTemplate>
    </asp:ListView>
    
    </div>
    </form>
</body>
</html>
