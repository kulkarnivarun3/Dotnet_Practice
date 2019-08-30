<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Paging</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:ScriptManager id="sm1" runat="server" />
    
    <%= DateTime.Now %>

    <asp:UpdatePanel id="up1" runat="Server">
    <ContentTemplate>
    
    <asp:DetailsView
        id="dtlMovies"
        DataSourceID="srcMovies"
        AllowPaging="true"
        Runat="server" />
    
    </ContentTemplate>
    </asp:UpdatePanel>
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director,InTheaters FROM Movies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
