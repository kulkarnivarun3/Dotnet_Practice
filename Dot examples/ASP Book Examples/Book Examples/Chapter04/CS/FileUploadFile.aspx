<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (upImage.HasFile)
        {
            if (CheckFileType(upImage.FileName))
            {
                String filePath = "~/UploadImages/" + upImage.FileName;
                upImage.SaveAs(MapPath(filePath));
            }
        }
    }

    bool CheckFileType(string fileName)
    {
        string ext = Path.GetExtension(fileName);
        switch (ext.ToLower())
        {
            case ".gif":
                return true;
            case ".png":
                return true;    
            case ".jpg":
                return true;            
            case ".jpeg":
                return true;
            default:
                return false;        
        }
    }

    void Page_PreRender()
    {
        string upFolder = MapPath("~/UploadImages/");
        DirectoryInfo dir = new DirectoryInfo(upFolder);
        dlstImages.DataSource = dir.GetFiles();
        dlstImages.DataBind();
    }
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
