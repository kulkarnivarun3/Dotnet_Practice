<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Frame Details</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DetailsView
        id="dtlMovie"
        DataSourceID="srcMovieDetails"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovieDetails"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Title, Director, InTheaters
            FROM Movies WHERE Id=@MovieId"
        Runat="server">
        <SelectParameters>
        <asp:QueryStringParameter
            Name="MovieId"
            QueryStringField="id" />    
        </SelectParameters>
    </asp:SqlDataSource>
        
    </div>
    </form>
</body>
</html>
