<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Master</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovieCategories"
        DataSourceID="srcMovieCategories"
        AutoGenerateColumns="false"
        Runat="server">
        <Columns>
        <asp:HyperLinkField
            HeaderText="Movie Categories"
            DataTextField="Name"
            DataNavigateUrlFields="Id"
            DataNavigateUrlFormatString="Details.aspx?id={0}" />
        </Columns>
    </asp:GridView>    
    
    <asp:SqlDataSource
        id="srcMovieCategories"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id, Name FROM MovieCategories"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
