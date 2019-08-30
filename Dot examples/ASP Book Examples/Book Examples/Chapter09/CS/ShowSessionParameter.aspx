<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    void Page_Load()
    {
        Session["MovieCategoryName"] = "Animation";
    }

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show SessionParameter</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Runat="server" />
        
    <asp:SqlDataSource
        id="srcMovies"
        SelectCommand="SELECT Name As Category,Title,Director 
            FROM Movies
            INNER JOIN MovieCategories
            ON CategoryId = MovieCategories.id
            WHERE Name=@Name"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        Runat="server">
        <SelectParameters>
        <asp:SessionParameter 
            Name="Name"
            SessionField="MovieCategoryName" />
        </SelectParameters>
    </asp:SqlDataSource>        
    
    </div>
    </form>
</body>
</html>
