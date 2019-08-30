<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            background-color:silver;
            font-family:Georgia, Serif;
        }
        .gridView
        {
            float:left;
            margin-right:20px;
            background-color:white;
        }
        .gridView td, .gridView th
        {
            padding:10px;
        }
        .selectedRow
        {
            background-color:yellow;
        }
    </style>
    <title>Select GridView</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovieCategories"
        DataKeyNames="Id"
        DataSourceID="srcMovieCategories"
        AutoGenerateSelectButton="true"
        SelectedRowStyle-CssClass="selectedRow"
        CssClass="gridView"
        Runat="server" />    
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        CssClass="gridView"
        Runat="server" />    
        
    <asp:SqlDataSource
        id="srcMovieCategories"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id, Name FROM MovieCategories"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Title,Director FROM Movies 
            WHERE CategoryId=@CategoryId"
        Runat="server">
        <SelectParameters>
        <asp:ControlParameter 
            Name="CategoryId"
            ControlID="grdMovieCategories"
            PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>        

    
    </div>
    </form>
</body>
</html>
