<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    /// <summary>
    /// Iterate through all parameters and check for null 
    /// </summary>
    protected void srcMovies_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        foreach (SqlParameter param in e.Command.Parameters)
        if (param.Value == null)
        {
            e.Cancel = true;
            lblError.Text = "All fields are required!";
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .error
        {
            display:block;
            color:red;
            font:bold 16px Arial;
            margin:10px;
        }
        td,th
        {
            padding:10px;
        }
    </style>
    <title>Cancel Command</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblError"
        EnableViewState="false"
        CssClass="error"
        Runat="server" />
    
    <asp:DetailsView
        id="dtlMovie"
        DataSourceID="srcMovies"
        DataKeyNames="Id"
        AllowPaging="true"
        AutoGenerateEditButton="true"
        Runat="server" />
            
    <asp:SqlDataSource
        id="srcMovies"
        SelectCommand="SELECT * FROM Movies"
        UpdateCommand="UPDATE Movies SET Title=@Title,
            Director=@Director,DateReleased=@DateReleased
            WHERE Id=@id"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        Runat="server" OnUpdating="srcMovies_Updating" />
    
    </div>
    </form>
</body>
</html>
