<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    Public Function FormatTitle(ByVal title As Object) As String
        Return "<b>" + title.ToString().ToUpper() + "</b>"
    End Function

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Format Movie Titles</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
   
    <asp:Repeater
        id="Repeater1"
        DataSourceId="srcMovies"
        Runat="server">
        <ItemTemplate>
        <%# FormatTitle(Eval("Title")) %> 
        <hr />
        </ItemTemplate>
    </asp:Repeater>    

    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="Data Source=.\SQLExpress;
            AttachDbFilename=|DataDirectory|MyDatabase.mdf;
            Integrated Security=True;User Instance=True"
        SelectCommand="SELECT Title FROM Movies"
        Runat="server" />
        
    </div>
    </form>
</body>
</html>
