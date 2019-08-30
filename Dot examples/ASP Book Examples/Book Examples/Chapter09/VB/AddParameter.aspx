<%@ Page Language="VB" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    Protected Sub srcGuestBook_Inserting(ByVal sender As Object, ByVal e As SqlDataSourceCommandEventArgs)
        e.Command.Parameters.Add(New SqlParameter("@Name", User.Identity.Name))
    End Sub

</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show ProfileParameter</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:FormView
        id="frmGuestBook"
        DataSourceID="srcGuestBook"
        DefaultMode="Insert"
        Runat="server">
        <InsertItemTemplate>
        <asp:Label
            id="lblComments"
            Text="Enter Your Comments:"
            Runat="server" />
        <br />
        <asp:TextBox
            id="txtComments"
            Text='<%# Bind("Comments") %>'
            TextMode="MultiLine"
            Columns="50"
            Rows="4"
            Runat="server" />
        <br />
        <asp:Button
            id="btnInsert"
            Text="Add Comments"
            CommandName="Insert"
            Runat="server" />        
        </InsertItemTemplate>
    </asp:FormView>    

    <hr />
    
    <asp:GridView
        id="grdGuestBook"
        DataSourceID="srcGuestBook"
        Runat="server" />
        
    <asp:SqlDataSource
        id="srcGuestBook"
        SelectCommand="SELECT Name,Comments,EntryDate 
            FROM GuestBook ORDER BY Id DESC"
        InsertCommand="INSERT GuestBook (Name,Comments)
            VALUES (@Name,@Comments)"
        ConnectionString="<%$ ConnectionStrings:GuestBook %>"
        Runat="server" OnInserting="srcGuestBook_Inserting" />
    
    </div>
    </form>
</body>
</html>
