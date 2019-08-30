<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show QueryStringParameter Master</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:GridView
        id="grdMovies"
        DataSourceId="srcMovies"
        AutoGenerateColumns="false"
        ShowHeader="false"
        Runat="server">
        <Columns>
        <asp:HyperLinkField 
            DataTextField="Title" 
            DataNavigateUrlFields="Id"
            DataNavigateUrlFormatString="ShowQueryStringParameterDetails.aspx?id={0}" />
        </Columns>
    </asp:GridView>          
            
    <asp:SqlDataSource
        id="srcMovies"
        SelectCommand="SELECT * FROM Movies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
