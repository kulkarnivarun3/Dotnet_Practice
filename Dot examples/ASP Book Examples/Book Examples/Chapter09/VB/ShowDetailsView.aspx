<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show DetailsView</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:DetailsView
        id="dtlMovie"
        DataKeyNames="Id"
        DataSourceID="srcMovies"
        AutoGenerateEditButton="true"
        DefaultMode="Edit"
        AllowPaging="true"
        runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="Select * FROM Movies"
        UpdateCommand="UPDATE Movies SET Title=@Title,Director=@Director,
            DateReleased=@DateReleased WHERE Id=@id"
        Runat="server" />

    </div>
    </form>
</body>
</html>
