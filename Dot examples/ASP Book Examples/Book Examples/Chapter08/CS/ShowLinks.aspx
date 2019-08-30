<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Links</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
   
    <asp:Repeater
        id="Repeater1"
        DataSourceId="srcMovies"
        Runat="server">
        <ItemTemplate>

        <asp:HyperLink
            id="HyperLink1"
            Text='<%# Eval("Title") %>'
            NavigateUrl='<%# Eval("Id", "Details.aspx?id={0}") %>'
            runat="server" />
        <br />
        
        </ItemTemplate>
    </asp:Repeater>    

    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="Data Source=.\SQLExpress;
            AttachDbFilename=|DataDirectory|MyDatabase.mdf;
            Integrated Security=True;User Instance=True"
        SelectCommand="SELECT Id, Title FROM Movies"
        Runat="server" />
        
    </div>
    </form>
</body>
</html>
