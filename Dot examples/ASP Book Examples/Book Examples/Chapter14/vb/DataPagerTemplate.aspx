<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected sub pg_PagerCommand(sender As object, e As DataPagerCommandEventArgs)
        e.NewMaximumRows = e.Item.Pager.MaximumRows
        select case e.CommandName
            Case "Previous"
                If e.Item.Pager.StartRowIndex > 0 Then
                    e.NewStartRowIndex = e.Item.Pager.StartRowIndex - 2
                End If
            Case "Next"
                e.NewStartRowIndex = e.Item.Pager.StartRowIndex + 2
        End Select
    end sub
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>DataPager Template</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:ListView 
            ID="lstMovies"
            DataSourceId="srcMovies"
            runat="server">
            <LayoutTemplate>
                <ul>
                <asp:Placeholder 
                    id="itemPlaceholder"
                    runat="server" />
                </ul>
                <asp:DataPager
                    id="pg"
                    PageSize="2"
                    Runat="server">
                    <Fields>
                        <asp:TemplatePagerField
                            OnPagerCommand="pg_PagerCommand"> 
                            <PagerTemplate>
                            <asp:LinkButton 
                                id="lnkPrevious"
                                Text="Previous"
                                CommandName="Previous"
                                Runat="server" />
                            <asp:LinkButton 
                                id="lnkNext"
                                Text="Next"
                                CommandName="Next"
                                Runat="server" />
                            </PagerTemplate>
                        </asp:TemplatePagerField>    
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
