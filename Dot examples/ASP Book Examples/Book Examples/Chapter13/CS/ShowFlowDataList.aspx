<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Flow DataList</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DataList
        id="dlstMovies"
        DataSourceID="srcMovies"
        RepeatLayout="Flow"
        Runat="server">
        <ItemTemplate>
        <%#Eval("Title")%>
        </ItemTemplate>
    </asp:DataList>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Title FROM Movies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
