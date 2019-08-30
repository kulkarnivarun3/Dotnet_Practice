<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void grdMovieCategories_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int categoryId = (int)DataBinder.Eval(e.Row.DataItem,"Id");
            SqlDataSource srcMovies = (SqlDataSource)e.Row.FindControl("srcMovies");
            srcMovies.SelectParameters["CategoryId"].DefaultValue = categoryId.ToString();
        }
    }

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
