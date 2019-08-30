<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show CommandField</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        DataKeyNames="Id"
        AutoGenerateColumns="false"
        Runat="server">
        <Columns>
        <asp:CommandField
            ButtonType="Image"
            ShowEditButton="true"
            EditText="Edit Movie"
            EditImageUrl="Edit.gif"
            UpdateText="Update Movie"
            UpdateImageUrl="Update.gif"            
            ShowCancelButton="true"
            CancelText="Cancel Edit"
            CancelImageUrl="Cancel.gif"
            ShowDeleteButton="true"
            DeleteText="Delete Movie"
            DeleteImageUrl="Delete.gif" />
        <asp:BoundField
            DataField="Title"
            HeaderText="Movie Title" />
        <asp:BoundField
            DataField="Director"
            HeaderText="Movie Director" />
        </Columns>
    </asp:GridView>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director FROM Movies"
        UpdateCommand="UPDATE Movies SET
            Title=@Title, Director=@Director
            WHERE Id=@Id"
        DeleteCommand="DELETE Movies
            WHERE Id=@Id"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
