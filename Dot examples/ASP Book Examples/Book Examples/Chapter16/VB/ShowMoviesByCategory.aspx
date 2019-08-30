<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
    .movies
    {
        border:Solid 1px black;
    }
    .movies td,.movies th
    {
        padding:5px;
    }
    </style>
    <title>Show Movies by Category</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DropDownList
        id="ddlMovieCategory"
        DataSourceID="srcMovieCategories"
        DataTextField="Name"
        DataValueField="Id"
        ToolTip="Movie Category"
        Runat="server" />
    <asp:Button
        id="btnSelect"
        Text="Select"
        Runat="server" />    
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        CssClass="movies"
        GridLines="None"
        Runat="server" />
        
    <asp:ObjectDataSource
        id="srcMovieCategories"
        TypeName="MovieCategories"
        SelectMethod="GetCategories"
        Runat="server" />        
        
    <asp:ObjectDataSource
        id="srcMovies"
        TypeName="MovieCategories"
        SelectMethod="GetMovies"
        Runat="server">
        <SelectParameters>
        <asp:ControlParameter
            Name="CategoryId"
            ControlID="ddlMovieCategory" />
       </SelectParameters>
    </asp:ObjectDataSource>                 

    </div>
    </form>
</body>
</html>
