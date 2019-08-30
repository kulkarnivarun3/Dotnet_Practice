<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
    html
    {
        background-color:silver;
    }
    .content
    {
        width:600px;
        height:400px;
        padding:10px;
        border:solid 1px black;
        background-color:white;
    }
    a
    {
        color:blue;
    }
    </style>
    <title>Show SeparatorTemplate</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="content">

    <asp:Repeater
        id="rptMovieCategories"
        DataSourceID="srcMovieCategories"
        Runat="server">
        <ItemTemplate>
        <asp:HyperLink
            id="lnkMenu"
            Text='<%#Eval("Name")%>'
            NavigateUrl='<%#Eval("Id","ShowSeparatorTemplate.aspx?id={0}")%>'
            Runat="server" />
        </ItemTemplate>
        <SeparatorTemplate>
        &nbsp;|&nbsp;
        </SeparatorTemplate>
    </asp:Repeater>

    <asp:Repeater
        id="rptMovies"
        DataSourceID="srcMovies"
        Runat="server">
        <HeaderTemplate>
        <ul>
        </HeaderTemplate>
        <ItemTemplate>
        <li><%#Eval("Title")%></li>
        </ItemTemplate>
        <FooterTemplate>
        </ul>
        </FooterTemplate>
    </asp:Repeater>    
    
    <asp:SqlDataSource
        id="srcMovieCategories"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id, Name
            FROM MovieCategories"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Title FROM Movies
            WHERE CategoryId=@CategoryId"
        Runat="server">
        <SelectParameters>
        <asp:QueryStringParameter
             Name="CategoryId"
             QueryStringField="Id" />
        </SelectParameters>
    </asp:SqlDataSource>    
    
    </div>
    </form>
</body>
</html>
