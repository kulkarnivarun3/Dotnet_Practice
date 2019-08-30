<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
    html
    {
        background-color:#Silver;
    }
    .movies
    {
        font:14px Arial,Sans-Serif;
    }
    .header
    {
        font-size:18px;
        letter-spacing:15px;
    }
    .item
    {
        padding:5px;
        background-color:#eeeeee;
        border-bottom:Solid 1px blue;
    }
    .alternating
    {
        padding:5px;
        background-color:LightBlue;
        border-bottom:Solid 1px blue;
    }
    </style>
    <title>Format DataList</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DataList
        id="dlstMovies"
        DataSourceID="srcMovies"
        UseAccessibleHeader="true"
        CssClass="movies"
        HeaderStyle-CssClass="header"
        ItemStyle-CssClass="item"
        AlternatingItemStyle-CssClass="alternating"
        Runat="server">
        <HeaderTemplate>
        Movies
        </HeaderTemplate>
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
