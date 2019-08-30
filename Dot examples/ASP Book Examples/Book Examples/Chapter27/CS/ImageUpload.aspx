<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (upFile.HasFile)
        {
                srcImages.Insert();
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .fileList li
        {
            margin-bottom:5px;
        }
    </style>
    <title>Image Upload</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:Label
        id="lblFile"
        Text="Image File:"
        AssociatedControlID="upFile"
        Runat="server" />
    <asp:FileUpload
        id="upFile"
        Runat="server" />
    <asp:Button
        id="btnAdd"
        Text="Add Image"
        OnClick="btnAdd_Click" 
        Runat="server" />
    <hr />

    <asp:GridView
        id="grdImages"
        DataSourceID="srcImages"
        AutoGenerateColumns="false"
        ShowHeader="false"
        GridLines="None"
        Runat="server">
        <Columns>
        <asp:ImageField 
            DataImageUrlField="FileName" 
            DataAlternateTextField="FileName" />
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource
        id="srcImages"
        ConnectionString="<%$ ConnectionStrings:Images %>"
        SelectCommand="SELECT FileName FROM Images"
        InsertCommand="INSERT Images (FileName,Image) VALUES (@FileName,@FileBytes)"
        Runat="server">
        <InsertParameters>
            <asp:ControlParameter Name="FileName" ControlID="upFile" PropertyName="FileName" />
            <asp:ControlParameter Name="FileBytes" ControlID="upFile" PropertyName="FileBytes" />
        </InsertParameters>
    </asp:SqlDataSource>
            
    </div>
    </form>
</body>
</html>
