<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>TreeView XML Complex</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:TreeView
        id="TreeView1"
        DataSourceID="srcMovies"
        Runat="server">
        <DataBindings>
        <asp:TreeNodeBinding 
            DataMember="category" 
            TextField="text" 
            ValueField="id" />
        <asp:TreeNodeBinding 
            DataMember="movie" 
            TextField="text" 
            ValueField="id" />
        </DataBindings>
    </asp:TreeView>    
    
    <asp:XmlDataSource
        id="srcMovies"
        DataFile="~/MoviesComplex.xml"
        Runat="server" />    
    
    </div>
    </form>
</body>
</html>
