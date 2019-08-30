<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Pager Settings</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DetailsView
        id="dtlMovies"
        DataSourceID="srcMovies"
        AllowPaging="true"
        Runat="server">
        <PagerSettings
            Mode="NextPreviousFirstLast" 
            FirstPageText="[First Movie]"
            LastPageText="[Last Movie]"
            NextPageText="[Next Movie]"
            PreviousPageText="[Previous Movie]" />
    </asp:DetailsView>        
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director,InTheaters FROM Movies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
