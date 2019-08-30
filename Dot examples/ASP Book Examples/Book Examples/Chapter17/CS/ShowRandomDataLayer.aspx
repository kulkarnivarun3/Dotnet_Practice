<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        lblRandomMovie.Text = RandomDataLayer.GetRandomMovie();
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show RandomDataLayer</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    Random Movie:
    <asp:Label
        id="lblRandomMovie"
        Runat="server" />
        
    <hr />
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Runat="server" />
    <asp:ObjectDataSource
        id="srcMovies"
        TypeName="RandomDataLayer"
        SelectMethod="GetRandomMovies"
        Runat="server" />        
    
    
    </div>
    </form>
</body>
</html>
