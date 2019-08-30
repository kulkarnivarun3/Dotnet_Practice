<%@ Page Language="C#" Trace="true" %>
<%@ Register TagPrefix="custom" Namespace="Superexpert.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void frmMovie_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            e.KeepInInsertMode = true;
            ValidationUtility.ShowValidationErrors(this, e.Exception);
        }
    }

</script>
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
        OnItemInserted="frmMovie_ItemInserted"
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
            <custom:EntityCallOutValidator
                id="valTitle"
                PropertyName="Title"
                Runat="Server" />
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
            <custom:EntityCallOutValidator
                id="valDirector"
                PropertyName="Director"
                Runat="Server" />
        
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
            <custom:EntityCallOutValidator
                id="valDateReleased"
                PropertyName="DateReleased"
                ControlToValidate="txtDateReleased"
                TypeName="date"
                Runat="Server" />
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
    
    <custom:EntityDataSource
        id="srcMovies"
        TypeName="Movie"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
