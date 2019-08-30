<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<script runat="server">
 
    Protected Sub srcMovies_Selected(ByVal sender As Object, ByVal e As SqlDataSourceStatusEventArgs)
        If Not e.Exception Is Nothing Then
            lblError.Text = e.Exception.Message
            e.ExceptionHandled = True
        End If
    End Sub
    
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
    <title>Handle Error</title>
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
        DataSourceID="srcMovies"
        Runat="server" />
        
    <asp:SqlDataSource
        id="srcMovies"
        SelectCommand="SELECT * FROM DontExist"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        OnSelected="srcMovies_Selected"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
