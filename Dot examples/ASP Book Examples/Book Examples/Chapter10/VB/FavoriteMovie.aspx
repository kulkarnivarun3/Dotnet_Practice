<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Favorite Movie</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:Label
        id="lblMovies"
        Text="Favorite Movie:"
        AssociatedControlID="rblMovies"
        Runat="server" />
    
    <asp:RadioButtonList
        id="rblMovies"
        Runat="server">
        <asp:ListItem 
            Text="The Remains of the Day" 
            Value="movie1" />
        <asp:ListItem
            Text="Star Wars"
            Value="movie2" />
        <asp:ListItem
            Text="Pulp Fiction"
            Value="movie3" />    
    </asp:RadioButtonList>

    </div>
    </form>
</body>
</html>
