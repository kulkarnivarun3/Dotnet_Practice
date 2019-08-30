<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Table ListView</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:ListView 
            ID="lstMovies"
            DataSourceId="srcMovies"
            runat="server">
            <LayoutTemplate>
                <table>
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Director</th>
                    </tr>                
                </thead>
                <tbody>
                    <asp:Placeholder 
                        id="itemPlaceholder" 
                        runat="server" />
                </tbody>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("Title") %></td>
                    <td><%# Eval("Director") %></td>
                </tr>
            </ItemTemplate>
            <EmptyDataTemplate>
                No records found
            </EmptyDataTemplate>
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
