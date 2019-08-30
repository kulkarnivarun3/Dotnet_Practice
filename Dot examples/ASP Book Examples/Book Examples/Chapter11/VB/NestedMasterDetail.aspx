<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Protected  Sub grdMovieCategories_RowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim categoryId As Integer = CType(DataBinder.Eval(e.Row.DataItem,"Id"), Integer)
            Dim srcMovies As SqlDataSource = CType(e.Row.FindControl("srcMovies"), SqlDataSource)
            srcMovies.SelectParameters("CategoryId").DefaultValue = categoryId.ToString()
        End If
    End Sub

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .categories h1
        {
            font:bold 16px Arial, Sans-Serif;
        }
        .movies
        {
            margin-left:20px;
            margin-bottom:10px;
            width:100%;
        }
    </style>
    <title>Nested Master/Detail</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovieCategories"
        OnRowDataBound="grdMovieCategories_RowDataBound" 
        AutoGenerateColumns="false"
        CssClass="categories"
        ShowHeader="false"
        GridLines="none"
        Runat="server">
        <Columns>
        <asp:TemplateField>
        <ItemTemplate>
            <h1><%# Eval("Name") %></h1>
            <asp:GridView
                id="grdMovies"
                DataSourceId="srcMovies"
                CssClass="movies"
                GridLines="none"
                Runat="server" />

            <asp:SqlDataSource
                id="srcMovies"
                ConnectionString="<%$ ConnectionStrings:Movies %>"
                SelectCommand="SELECT Title,Director FROM Movies
                    WHERE CategoryId=@CategoryId"
                Runat="server">
                <SelectParameters>
                    <asp:Parameter Name="CategoryId" />
                </SelectParameters>
            </asp:SqlDataSource>    
        </ItemTemplate>
        </asp:TemplateField>    
        </Columns>
    </asp:GridView>
    
    <asp:SqlDataSource
        id="srcMovieCategories"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Name FROM MovieCategories"
        Runat="server" />


    
    </div>
    </form>
</body>
</html>
