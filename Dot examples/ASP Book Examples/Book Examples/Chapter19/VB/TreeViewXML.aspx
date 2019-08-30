<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>TreeView XML</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:TreeView
        id="TreeView1"
        DataSourceID="srcMovies"
        Runat="server" />
        
     <asp:XmlDataSource
        id="srcMovies"
        DataFile="~/Movies.xml"
        Runat="server" />   
    
    </div>
    </form>
</body>
</html>
