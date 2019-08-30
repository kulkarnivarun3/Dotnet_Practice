<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .movies td,.movies th
        {
            padding:5px;
        }
    </style>
    <title>Show Data Source Paging</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        AllowPaging="true"
        PageSize="3"
        CssClass="movies"
        Runat="server" />
        
    <asp:ObjectDataSource
        id="srcMovies"
        TypeName="MoviesDSPaging"
        SelectMethod="GetMovies"
        SelectCountMethod="GetMovieCount"
        EnablePaging="True"
        Runat="server" />    
    
    </div>
    </form>
</body>
</html>
