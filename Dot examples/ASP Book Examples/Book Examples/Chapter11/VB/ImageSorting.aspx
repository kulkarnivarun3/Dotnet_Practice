<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Protected Sub grdMovies_RowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.Header Then
            For Each cell As TableCell In e.Row.Cells
                Dim sortLink As LinkButton = CType(cell.Controls(0), LinkButton)
                If sortLink.Text = grdMovies.SortExpression Then
                    If grdMovies.SortDirection = SortDirection.Ascending Then
                        sortLink.Text += " <img src='asc.gif' title='Sort ascending' />"
                    Else
                        sortLink.Text += " <img src='desc.gif' title='Sort descending' />"
                    End If
                End If
            Next
        End If
    End Sub

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        img
        {
            border:0px;
        }
    </style>
    <title>Image Sorting</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        AllowSorting="true"
        Runat="server" OnRowDataBound="grdMovies_RowDataBound" />     
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director FROM Movies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
