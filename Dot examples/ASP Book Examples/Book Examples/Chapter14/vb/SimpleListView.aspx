<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Simple ListView</title>
</head>
<body>
    <form id="form1" runat="server">
        
        <asp:ListView 
            ID="lstMovies"
            DataSourceId="srcMovies"
            runat="server">
            <LayoutTemplate>
                <div style="border:dashed 1px black"> 
                    <asp:Placeholder 
                        id="itemPlaceholder"
                        runat="server" />
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <div style="border:solid 1px black">
                <%# Eval("Title") %>
                </div>
            </ItemTemplate>
            <AlternatingItemTemplate>
                <div style="border:solid 1px black;background-color:Silver">
                <%# Eval("Title") %>
                </div>
            </AlternatingItemTemplate>
            <EmptyDataTemplate>
                No records found
            </EmptyDataTemplate>
        </asp:ListView>
    
        <asp:SqlDataSource
            id="srcMovies"
            SelectCommand="SELECT Id, Title, Director FROM Movie"
            ConnectionString='<%$ ConnectionStrings:con %>'
            Runat="server" />
    
    </form>
</body>
</html>
