<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Edit GridView</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        DataKeyNames="Id"
        AutoGenerateEditButton="true"
        AutoGenerateDeleteButton="true"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director FROM Movies"
        UpdateCommand="UPDATE Movies SET Title=@Title, Director=@Director
            WHERE Id=@Id"
        DeleteCommand="DELETE Movies WHERE Id=@Id"    
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
