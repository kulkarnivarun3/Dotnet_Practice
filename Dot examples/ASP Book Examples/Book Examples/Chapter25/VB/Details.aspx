<%@ Page Language="VB" %>
<%@ OutputCache Duration="3600" VaryByParam="id" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Details</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <%= DateTime.Now.ToString("T") %>
    
    <hr />
    
    <asp:DetailsView
        id="dtlMovie"
        DataSourceID="srcMovies"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT * FROM Movies
            WHERE Id=@Id"
        Runat="server">
        <SelectParameters>
            <asp:QueryStringParameter
                Name="Id"
                Type="int32"
                QueryStringField="Id" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
