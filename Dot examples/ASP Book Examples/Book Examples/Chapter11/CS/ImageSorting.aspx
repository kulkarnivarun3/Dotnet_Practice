<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void grdMovies_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            foreach (TableCell cell in e.Row.Cells)
            {
                LinkButton sortLink = (LinkButton)cell.Controls[0];
                if (sortLink.Text == grdMovies.SortExpression)
                {
                    if (grdMovies.SortDirection == SortDirection.Ascending)
                        sortLink.Text += " <img src='asc.gif' title='Sort ascending' />";
                    else
                        sortLink.Text += " <img src='desc.gif' title='Sort descending' />";

                }
            }
        }
    }
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
