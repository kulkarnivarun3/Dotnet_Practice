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
    
    <asp:DetailsView
        id="dtlMovies"
        DataKeyNames="Id"
        AutoGenerateEditButton="true"
        AllowPaging="true"
        DataSourceID="srcMovies"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director,InTheaters FROM Movies"
        UpdateCommand="UPDATE Movies 
            SET Title=@Title,Director=@Director,InTheaters=@InTheaters 
            WHERE Title=@original_Title 
            AND Director=@original_Director
            AND InTheaters=@InTheaters
            AND Id=@original_Id"
        ConflictDetection="CompareAllValues"  
        OldValuesParameterFormatString="original_{0}"  
        Runat="server" OnUpdated="srcMovies_Updated" />
    
    </div>
    </form>
</body>
</html>
