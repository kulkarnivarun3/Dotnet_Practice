<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show CheckBoxField</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        DataKeyNames="Id"
        AutoGenerateColumns="false"
        AutoGenerateEditButton="true"
        Runat="server">
        <Columns>
        <asp:BoundField
            DataField="Title"
            HeaderText="Movie Title" />
        <asp:CheckBoxField
            DataField="InTheaters"
            HeaderText="In Theaters" />
        </Columns>
    </asp:GridView>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,InTheaters FROM Movies"
        UpdateCommand="UPDATE Movies SET
            Title=@Title, InTheaters=@InTheaters
            WHERE Id=@Id"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
