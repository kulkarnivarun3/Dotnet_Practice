<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Local Connection</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Runat="server" />
        
    <asp:SqlDataSource
        id="srcMovies"
        SelectCommand="SELECT * FROM Movies"
        ConnectionString="Data Source=.\SQLEXPRESS;
            AttachDbFilename=|DataDirectory|MyDatabase.mdf;
            Integrated Security=True;User Instance=True"
        Runat="server" />
    
    
    </div>
    </form>
</body>
</html>
