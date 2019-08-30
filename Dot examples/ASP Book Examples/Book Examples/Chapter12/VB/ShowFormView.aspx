<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
    html
    {
        background-color:silver;
    }
    #content
    {
        margins:auto;
        width:600px;
        padding:10px;
        background-color:white;
        font:14px Georgia,Serif;
    }
    </style>
    <title>Show FormView</title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="content">
    
    <asp:FormView
        id="frmMovies"
        DataSourceID="srcMovies"
        Runat="server">
        <ItemTemplate>
        <h1><%# Eval("Title") %></h1>
        <b>Directed By:</b> 
        <%# Eval("Director") %>
        <br />
        <b>Box Office Totals:</b> 
        <%#Eval("BoxOfficeTotals", "{0:c}") %>
        </ItemTemplate>
    </asp:FormView>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director,BoxOfficeTotals FROM Movies
            WHERE Id=1"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
