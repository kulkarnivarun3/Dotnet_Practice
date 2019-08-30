<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Protected Sub dtlMovies_ItemInserted(ByVal sender As Object, ByVal e As DetailsViewInsertedEventArgs)
        If Not IsNothing(e.Exception) Then
            e.ExceptionHandled = True
            e.KeepInInsertMode = True
            lblError.Visible = True
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .error
        {
            color:red;
            font:bold 14px Arial,Sans-Serif;
        }
    </style>
    <title>Insert Errors</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblError"
        Text="Could not insert record"
        Visible="false"
        EnableViewState="false"
        CssClass="error"
        Runat="server" />
    
    <asp:DetailsView
        id="dtlMovies"
        AllowPaging="true"
        DataSourceID="srcMovies"
        AutoGenerateInsertButton="true"
        OnItemInserted="dtlMovies_ItemInserted"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Title,Director,InTheaters FROM Movies"
        InsertCommand="INSERT Movies (Title,Director,InTheaters)
            VALUES (@Title,@Director,@InTheaters)"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
