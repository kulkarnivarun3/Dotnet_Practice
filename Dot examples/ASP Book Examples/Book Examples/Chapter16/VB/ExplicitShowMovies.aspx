<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Movies</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        DataKeyNames="Id"
        AutoGenerateEditButton="true"
        Runat="server" />
        
    <asp:ObjectDataSource
        id="srcMovies"
        TypeName="Movies"
        SelectMethod="GetMovies"
        UpdateMethod="UpdateMovie"
        Runat="server">
        <UpdateParameters>
        <asp:Parameter Name="title" />
        <asp:Parameter Name="director" />
        <asp:Parameter Name="dateReleased" Type="DateTime" />
        <asp:Parameter Name="id" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>    
    
    </div>
    </form>
</body>
</html>
