<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Master</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        AutoGenerateColumns="false"
        ShowHeader="false"
        GridLines="none"
        Runat="server">
        <Columns>
        <asp:HyperLinkField
            DataTextField="Title"
            DataNavigateUrlFields="Id"
            DataNavigateUrlFormatString="~/Details.aspx?id={0}" />
        </Columns>    
    </asp:GridView>
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title FROM Movies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
