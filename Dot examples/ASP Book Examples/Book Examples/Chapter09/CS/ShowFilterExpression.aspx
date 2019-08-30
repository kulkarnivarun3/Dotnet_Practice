<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        td, th
        {
            padding:10px;
        }
    
    </style>
    <title>Show Filter Expression</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:TextBox
        id="txtTitle"
        Runat="server" />
    <asp:Button
        id="btnMatch"
        Text="Match"
        Runat="server" />    
    <hr />
    
    <asp:GridView
        id="grdMovies"
        DataSourceId="srcMovies"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        SelectCommand="SELECT Id,Title,Director,DateReleased 
            FROM Movies"
        FilterExpression="Title LIKE '{0}%'"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        Runat="server">
        <FilterParameters>
            <asp:ControlParameter Name="Title" ControlID="txtTitle" />    
        </FilterParameters>
    </asp:SqlDataSource>
        
    </div>
    </form>
</body>
</html>
