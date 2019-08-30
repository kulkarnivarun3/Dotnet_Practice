<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Bound GridView</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="GridView1"
        DataSourceId="srcMovies"
        Runat="server" />

    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="Data Source=.\SQLExpress;
            AttachDbFilename=|DataDirectory|MyDatabase.mdf;
            Integrated Security=True;User Instance=True"
        SelectCommand="SELECT * FROM Movies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
