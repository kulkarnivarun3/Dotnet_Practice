<%@ Page Language="C#" %>
<%@ Register TagPrefix="custom" Namespace="AspNetUnleashed" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .movies
        {
            width:500px;
        }
        .movies div
        {
            border:solid 1px black;
            padding:10px;
            margin:10px;
        }
    </style>
    <title>Show DivView</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <custom:DivView
        id="lstMovies"
        DataSourceID="srcMovies"
        CssClass="movies"
        Runat="Server">
        <ItemTemplate>
        <h1><%# Eval("Title") %></h1>
        Director: <%# Eval("Director") %>
        </ItemTemplate>
    </custom:DivView>
    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Title, Director FROM Movies"
        Runat="server" />
        
    <br />
    <asp:LinkButton
        id="lnkReload"
        Text="Reload"
        Runat="server" />    
        
        
    </div>
    </form>
</body>
</html>
