<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<script runat="server">

    protected void srcMovies_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows == 0)
            lblMessage.Text = "Could not update record";
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Concurrency</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label ID="lblMessage" EnableViewState="false" runat="server" />
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        DataKeyNames="Id"
        AutoGenerateEditButton="true"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        ConflictDetection="CompareAllValues"
        OldValuesParameterFormatString="original_{0}"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director FROM Movies"
        UpdateCommand="UPDATE Movies SET Title=@Title, Director=@Director
            WHERE Id=@original_Id AND Title=@original_Title AND Director=@original_Director"
        Runat="server" OnUpdated="srcMovies_Updated" />
    
    </div>
    </form>
</body>
</html>
