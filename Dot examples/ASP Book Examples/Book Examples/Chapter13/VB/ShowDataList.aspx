<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show DataList</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DataList
        id="dlstMovies"
        DataSourceID="srcMovies"
        Runat="server">
        <ItemTemplate>
        <h1><%#Eval("Title")%></h1>
        Directed by: 
        <%#Eval("Director") %>
        <br />
        Box Office Totals:
        <%#Eval("BoxOfficeTotals","{0:c}") %>
        </ItemTemplate>
    </asp:DataList>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Title,Director,BoxOfficeTotals
            FROM Movies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
