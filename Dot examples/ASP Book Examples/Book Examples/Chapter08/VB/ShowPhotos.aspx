<%@ Page Language="VB" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    ''' <summary>
    ''' Bind photos to Repeater
    ''' </summary>
    Sub Page_Load()
        If Not Page.IsPostBack Then
            Repeater1.DataSource = GetPhotos()
            Repeater1.DataBind()
        End If
    End Sub
    
    ''' <summary>
    ''' Get list of photos from Photo folder
    ''' </summary>
    Public Function GetPhotos() As List(Of String)
        Dim photos As New List(Of String)()
        Dim photoPath As String = MapPath("~/Photos")
        Dim files As String() = Directory.GetFiles(photoPath)
        For Each photo As String In files
            photos.Add("~/Photos/" + Path.GetFileName(photo))
        Next
        Return photos
    End Function
    
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
