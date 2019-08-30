<%@ Page Language="VB" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .grid td, .grid th
        {
            padding:5px;
        }
    </style>
    <title>Show LongTextField</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        CssClass="grid"
        DataSourceID="srcMovies"
        DataKeyNames="Id"
        AutoGenerateColumns="false"
        AutoGenerateEditButton="true"
        Runat="server">
        <Columns>
        <asp:BoundField
            DataField="Title"
            HeaderText="Movie Title" />
        <asp:BoundField
            DataField="Director"
            HeaderText="Movie Director" />
        <custom:LongTextField
            DataField="Description"
            Width="300px"
            Height="60px"
            HeaderText="Movie Description" />
        </Columns>
    </asp:GridView>    

    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id, Title, Director, Description
            FROM Movies"
        UpdateCommand="UPDATE Movies SET
            Title=@Title,Director=@Director,Description=@Description
            WHERE Id=@Id"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
