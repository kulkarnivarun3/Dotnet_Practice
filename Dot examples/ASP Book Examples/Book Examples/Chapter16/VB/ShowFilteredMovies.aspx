<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Filtered Movies</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DropDownList
        id="ddlMovieCategory"
        DataSourceID="srcMovieCategories"
        DataTextField="Name"
        DataValueField="Id"
        Runat="server" />
    <asp:Button
        id="btnSelect"
        Text="Select"
        Runat="server" />
        
    <hr />
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        AutoGenerateColumns="false"
        Runat="server">
        <Columns>
        <asp:BoundField
            DataField="Title"
            HeaderText="Movie Title" />
        <asp:BoundField
            DataField="Director"
            HeaderText="Movie Director" />    
        </Columns>
    </asp:GridView>        
    
    <asp:ObjectDataSource
        id="srcMovieCategories"
        TypeName="FilterMovies"
        SelectMethod="GetMovieCategories"
        EnableCaching="true"
        CacheDuration="Infinite"
        Runat="server" />
        
    <asp:ObjectDataSource
        id="srcMovies"
        TypeName="FilterMovies"
        SelectMethod="GetMovies"
        EnableCaching="true"
        CacheDuration="Infinite"
        FilterExpression="CategoryID={0}"
        Runat="server">
        <FilterParameters>
        <asp:ControlParameter 
            Name="Category"
            ControlID="ddlMovieCategory" />
        </FilterParameters>
    </asp:ObjectDataSource>    
    
    
    </div>
    </form>
</body>
</html>
