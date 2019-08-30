<%@ Page Language="VB" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    Sub btnAdd_Click(ByVal sender As Object, ByVal e As EventArgs)
        If (upImage.HasFile) Then
            If (CheckFileType(upImage.FileName)) Then
                Dim filePath As String = "~/UploadImages/" & upImage.FileName
                upImage.SaveAs(MapPath(filePath))
            End If
        End If
    End Sub
 
    Function CheckFileType(ByVal fileName As String) As Boolean
        Dim ext As String = Path.GetExtension(fileName)
        Select Case ext.ToLower()
            Case ".gif"
                Return True
            Case ".png"
                Return True
            Case ".jpg"
                Return True
            Case ".jpeg"
                Return True
            Case Else
                Return False
        End Select
    End Function
 
    Sub Page_PreRender()
        Dim upFolder As String = MapPath("~/UploadImages/")
        Dim dir As New DirectoryInfo(upFolder)
        dlstImages.DataSource = dir.GetFiles()
        dlstImages.DataBind()
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>FileUpload File</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:Label
        id="lblImageFile"
        Text="Image File:"
        AssociatedControlID="upImage"
        Runat="server" />

    <asp:FileUpload
        id="upImage"
        Runat="server" />

    <br /><br />
    
    <asp:Button
        id="btnAdd"
        Text="Add Image"
        OnClick="btnAdd_Click" 
        Runat="server" />

    <hr />
    
    <asp:DataList
        id="dlstImages"
        RepeatColumns="3"
        runat="server">
        <ItemTemplate>
        <asp:Image ID="Image1" 
            ImageUrl='<%# Eval("Name", "~/UploadImages/{0}") %>'
            style="width:200px"
            Runat="server" />
        <br />
        <%# Eval("Name") %>    
        </ItemTemplate>
    </asp:DataList>
    
    </div>
    </form>
</body>
</html>
