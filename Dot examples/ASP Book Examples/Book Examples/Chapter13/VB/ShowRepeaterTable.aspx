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
        border:solid 1px black;
        background-color:white;
    }
    .movies
    {
        border-collapse:collapse;
    }
    .movies th,.movies td
    {
        padding:10px;
        border-bottom:1px solid black;
    }
    .alternating
    {
        background-color:#eeeeee;
    }
    </style>
    <title>Show Repeater Table</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="content">

    <asp:Repeater
        id="rptMovies"
        DataSourceID="srcMovies"
        Runat="server">
        <HeaderTemplate>
        <table class="movies">
        <tr>
            <th>Movie Title</th>
            <th>Movie Director</th>
            <th>Box Office Totals</th>
        </tr>    
        </HeaderTemplate>
        <ItemTemplate>
        <tr>
            <td><%#Eval("Title") %></td>
            <td><%#Eval("Director") %></td>
            <td><%#Eval("BoxOfficeTotals","{0:c}") %></td>
        </tr>    
        </ItemTemplate>
        <AlternatingItemTemplate>
        <tr class="alternating">
            <td><%#Eval("Title") %></td>
            <td><%#Eval("Director") %></td>
            <td><%#Eval("BoxOfficeTotals","{0:c}") %></td>
        </tr>    
        </AlternatingItemTemplate>
        <FooterTemplate>
        </table>
        </FooterTemplate>
    </asp:Repeater>
    
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
