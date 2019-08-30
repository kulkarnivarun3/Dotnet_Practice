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
        background-color:#eeeeee;
    }
    .movies
    {
        margin:20px 10px;
        padding:10px;
        border:dashed 2px black;
        background-color:white;
    }
    </style>
    <title>Show Repeater</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="content">

    <asp:Repeater
        id="rptMovies"
        DataSourceID="srcMovies"
        Runat="server">
        <ItemTemplate>
        <div class="movies">
        <h1><%#Eval("Title") %></h1>
        <b>Directed by:</b> <%# Eval("Director") %>
        <br />
        <b>Box Office Totals:</b> <%# Eval("BoxOfficeTotals","{0:c}") %>
        </div>    
        </ItemTemplate>
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
