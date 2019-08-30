<%@ Page Language="VB" Trace="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Insert Movie</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:FormView
        id="frmMovie"
        DataSourceID="srcMovies"
        DefaultMode="Insert"
        Runat="Server">
        <InsertItemTemplate>
            <asp:Label
                id="lblTitle"
                Text="Title:"
                AssociatedControlID="txtTitle"
                Runat="server" />
            <br />
            <asp:TextBox
                id="txtTitle"
                Text='<%# Bind("Title") %>'
                Runat="server" />                
      
            <br /><br />

            <asp:Label
                id="lblCategory"
                Text="Category:"
                AssociatedControlID="ddlCategory"
                Runat="server" />
            <br />
            <asp:DropDownList
                id="ddlCategory"
                DataSourceId="srcMovieCategories"
                SelectedValue='<%# Bind("CategoryId") %>'
                DataTextField="Name"
                DataValueField="Id"
                Runat="server" />                
            <asp:ObjectDataSource
                id="srcMovieCategories"
                TypeName="MovieCategory"
                SelectMethod="Select"
                Runat="Server" />
            <br /><br / >

            <asp:Label
                id="lblDirector"
                Text="Director:"
                AssociatedControlID="txtDirector"
                Runat="server" />
            <br />
            <asp:TextBox
                id="txtDirector"
                Text='<%# Bind("Director") %>'
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
                Columns="60"
                Rows="3"
                Runat="server" />                
        
            <br /><br />

            <asp:Label
                id="lblDateReleased"
                Text="Date Released:"
                AssociatedControlID="txtDateReleased"
                Runat="server" />
            <br />
            <asp:TextBox
                id="txtDateReleased"
                Text='<%# Bind("DateReleased") %>'
                Runat="server" />                

            <br /><br />

            <asp:Button
                id="btnInsert"
                Text="Insert"
                CommandName="Insert"
                Runat="server" />
        
        </InsertItemTemplate>    
    </asp:FormView>
    
    <hr />
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Runat="server" />
    
    <asp:ObjectDataSource
        id="srcMovies"
        TypeName="Movie"
        DataObjectTypeName="Movie"
        SelectMethod="Select"
        InsertMethod="Insert"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
