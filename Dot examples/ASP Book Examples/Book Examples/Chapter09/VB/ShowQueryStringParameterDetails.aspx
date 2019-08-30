<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show QueryStringParameter Details</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DetailsView
        id="dtlMovie"
        DataSourceID="srcMovie"
        Runat="server" />
                
    <asp:SqlDataSource
        id="srcMovie"
        SelectCommand="SELECT * FROM Movies
            WHERE Id=@Id"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        Runat="server">
        <SelectParameters>
            <asp:QueryStringParameter
                Name="Id"
                QueryStringField="Id" />
        </SelectParameters>
    </asp:SqlDataSource>
        
    </div>
    </form>
</body>
</html>
