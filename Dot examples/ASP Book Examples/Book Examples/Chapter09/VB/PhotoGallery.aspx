<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Photo Gallery</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DataList
        id="dlstImages"
        DataSourceID="srcImages"
        RepeatColumns="3"
        Runat="server">
        <ItemTemplate>
        <asp:Image ID="Image1"
            ImageUrl='<%# String.Format("DynamicImage.ashx?id={0}", Eval("Id")) %>'
            Width="250"
            Runat="server" />
        <br />
        <%# Eval("Description") %>
    </ItemTemplate>
    </asp:DataList>
         
    <hr />

    <asp:FormView
        id="frmImage"
        DataSourceID="srcImages"
        DefaultMode="Insert"
        Runat="server">
        <InsertItemTemplate>
        <asp:Label
            id="lblImage"
            Text="Upload Image:"
            AssociatedControlId="upImage"
            Runat="server" />
        <br />    
        <asp:FileUpload
            id="upImage"
            FileBytes='<%# Bind("Image") %>'
            Runat="server" />
        
        <br /><br />
        
        <asp:Label
            id="lblDescription"
            Text="Description:"
            AssociatedControlID="txtDescription"
            Runat="server" />
        <br />    
        <asp:TextBox
            id="txtDescription"
            Text='<%# Bind("Description") %>'
            TextMode="MultiLine"
            Columns="50"
            Rows="2"
            Runat="server" />    
        
        <br /><br />
        
        <asp:Button
            id="btnInsert"
            Text="Add Image"
            CommandName="Insert"
            Runat="server" />    
        </InsertItemTemplate>
    </asp:FormView>    
        
   
    
    <asp:SqlDataSource
        id="srcImages"
        SelectCommand="SELECT ID,Description FROM Images"
        InsertCommand="INSERT Images (Image,Description)
            VALUES (@Image,@Description)"
        ConnectionString="<%$ ConnectionStrings:Images %>"
        Runat="server" />
    
    
    </div>
    </form>
</body>
</html>
