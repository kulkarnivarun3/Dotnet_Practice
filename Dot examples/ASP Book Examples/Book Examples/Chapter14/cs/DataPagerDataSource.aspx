<%@ Page Language="C#" Trace="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>DataPager DataSource Paging</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    
    <asp:ListView 
        ID="lstMovies"
        DataSourceId="srcMovies"
        runat="server">
        <LayoutTemplate>
            <ol>
            <asp:PlaceHolder 
                id="itemPlaceholder"
                runat="server" />
            </ol>
            <asp:DataPager
                id="pg"
                PageSize="2"
                Runat="server">
                <Fields>
                    <asp:NumericPagerField />
                </Fields>
            </asp:DataPager>    

        </LayoutTemplate>
        <ItemTemplate>
            <li>
            <%# Eval("Title") %>
            </li>
        </ItemTemplate>
    </asp:ListView>

    
    <asp:LinqDataSource
        id="srcMovies"
        ContextTypeName="MyDatabaseDataContext"
        TableName="Movies"
        AutoPage="true"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
