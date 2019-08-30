<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .floater
        {
            float:left;
            width:45%;
            border:solid 1px black;
            padding:5px;
            margin:5px;
        }
    </style>
    <title>Show Hierarchical Databound Controls</title>
</head>
<body>
    <form id="form1" runat="server">

    <div class="floater">
    <h3>TreeView</h3>
    <asp:TreeView
        id="CheckBoxList1"
        DataSourceId="srcMovies"
        Runat="server" />
    </div>

    <div class="floater">
    <h3>Menu</h3>
    <asp:Menu
        id="BulletedList1"
        DataSourceId="srcMovies"
        Runat="server" />
    </div>
    
    <asp:XmlDataSource
        id="srcMovies"
        DataFile="~/Movies.xml"
        XPath="/movies/*"
        Runat="server" />
    
    </form>
</body>
</html>
