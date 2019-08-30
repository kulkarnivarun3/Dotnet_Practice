<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void frmPhoto_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        // Get the FileUpload control
        FileUpload upPhoto = (FileUpload)frmPhoto.FindControl("upPhoto");
        srcImages.InsertParameters["FileName"].DefaultValue = upPhoto.FileName;           

        string savePath = MapPath("~/Photos/" + upPhoto.FileName);
        // Save contents to file system
        upPhoto.SaveAs(savePath);
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show ImageField</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdImages"
        DataSourceID="srcImages"
        AutoGenerateColumns="false"
        ShowHeader="false"
        Runat="server">
        <Columns>
        <asp:ImageField
            DataImageUrlField="FileName"
            DataImageUrlFormatString="~/Photos/{0}" 
            DataAlternateTextField="AltText"
            ControlStyle-Width="200px" />
        </Columns>
    </asp:GridView>
    
    <asp:SqlDataSource
        id="srcImages"
        ConnectionString="<%$ ConnectionStrings:Photos %>"
        SelectCommand="SELECT FileName, AltText FROM Photos"
        InsertCommand="INSERT Photos (FileName, AltText) 
            VALUES (@FileName, @AltText)"
        Runat="server">
        <InsertParameters>
            <asp:Parameter Name="FileName" />
        </InsertParameters>
    </asp:SqlDataSource>     
            
    <hr />
    <asp:FormView
        id="frmPhoto"
        DefaultMode="Insert"
        DataSourceID="srcImages"
        OnItemInserting="frmPhoto_ItemInserting"
        Runat="server">
        <InsertItemTemplate>
        <h1>Add Photo</h1>
        <asp:Label
            id="lblPhoto"
            Text="Photo:"
            AssociatedControlID="upPhoto"
            Runat="server" />
        <br />
        <asp:FileUpload
            id="upPhoto"
            Runat="server" />
        <br />
        <asp:Label
            id="lblAltText"
            Text="Alternate Text:"
            AssociatedControlID="txtAltText"
            Runat="server" />
        <br />
        <asp:TextBox
            id="txtAltText"
            Text='<%# Bind("AltText") %>'
            Columns="50"
            Runat="server" />
        <br />
        <asp:Button
            id="btnInsert"
            Text="Add New Photo"
            CommandName="Insert"
            Runat="server" />            
        </InsertItemTemplate>
    </asp:FormView>
    
    </div>
    </form>
</body>
</html>
