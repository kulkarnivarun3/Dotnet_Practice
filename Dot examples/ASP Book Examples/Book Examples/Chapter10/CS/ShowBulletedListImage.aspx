<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show BulletedList Image</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:BulletedList
        id="blMovies"
        DataSourceID="srcMovies"
        DataTextField="Title"
        BulletStyle="CustomImage"
        BulletImageUrl="~/Images/Bullet.gif"
        Runat="server" />
       
    <asp:SqlDataSource
        id="srcMovies"
        SelectCommand="SELECT Title FROM Movies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
