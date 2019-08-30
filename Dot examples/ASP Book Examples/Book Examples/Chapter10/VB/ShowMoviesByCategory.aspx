<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .gridView
        {
            margin-top:20px;
        }
        .gridView td, .gridView th
        {
            padding:10px;
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
        Runat="server" />

    <asp:Button
        id="btnSelect"
        Text="Select"
        Runat="server" />
   
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        CssClass="gridView"
        Runat="server" />

    <asp:SqlDataSource
        id="srcMovieCategories"
        SelectCommand="SELECT Id, Name FROM MovieCategories"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        Runat="server" />

    <asp:SqlDataSource
        id="srcMovies"
        SelectCommand="SELECT Title,Director FROM Movies
            WHERE CategoryId=@Id"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        Runat="server">
        <SelectParameters>
        <asp:ControlParameter 
            Name="Id" 
            ControlID="ddlMovieCategory" 
            PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>    
    
    </div>
    </form>
</body>
</html>
