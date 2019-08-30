<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>DataPager ListView</title>
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
                        <asp:NextPreviousPagerField 
                            ShowFirstPageButton="true"
                            ShowPreviousPageButton="true"
                            ShowNextPageButton="false"
                            ShowLastPageButton="false" />
                        <asp:NumericPagerField />
                        <asp:NextPreviousPagerField 
                            ShowFirstPageButton="false"
                            ShowPreviousPageButton="false"
                            ShowNextPageButton="true"
                            ShowLastPageButton="true" />
                    </Fields>
                </asp:DataPager>    

            </LayoutTemplate>
            <ItemTemplate>
                <li>
                <%# Eval("Title") %>
                </li>
            </ItemTemplate>
        </asp:ListView>
    
        <asp:SqlDataSource
            id="srcMovies"
            SelectCommand="SELECT Id, Title, Director FROM Movie"
            ConnectionString='<%$ ConnectionStrings:con %>'
            Runat="server" />
    
    </div>
    </form>
</body>
</html>
