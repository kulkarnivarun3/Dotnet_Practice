<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show DataList</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DataList
        id="DataList1"
        DataSourceId="srcMovies"
        Runat="server">
        <ItemTemplate>
        <b>Movie Title:</b> 
        <%#Eval("Title")%> 
        <br />
        <b>Date Released:</b> 
        <%#Eval("DateReleased", "{0:D}") %>
        <hr />
        </ItemTemplate>
    </asp:DataList>    

    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="Data Source=.\SQLExpress;
            AttachDbFilename=|DataDirectory|MyDatabase.mdf;
            Integrated Security=True;User Instance=True"
        SelectCommand="SELECT Title,Director,DateReleased FROM Movies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
