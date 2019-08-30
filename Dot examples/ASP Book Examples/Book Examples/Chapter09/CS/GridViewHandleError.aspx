<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void grdMovies_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        if (e.Exception != null)
        {
            lblError.Text = e.Exception.Message;
            e.ExceptionHandled = true;
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
    </style>
    <title>GridView Handle Error</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblError"
        EnableViewState="false"
        CssClass="error"
        Runat="server" />
    
    <asp:GridView
        id="grdMovies"
        DataKeyNames="Id"
        AutoGenerateEditButton="true"
        DataSourceID="srcMovies"
        OnRowUpdated="grdMovies_RowUpdated"
        Runat="server"  />
        
    <asp:SqlDataSource
        id="srcMovies"
        SelectCommand="SELECT Id,Title FROM Movies"
        UpdateCommand="UPDATE DontExist SET Title=@Title 
            WHERE Id=@ID"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
