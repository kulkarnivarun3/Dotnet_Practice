<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Public ReadOnly Property IPAddress() As String
        Get
            Return Request.UserHostAddress
        End Get
    End Property

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Page Control Parameter</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:FormView
        id="frmGuestBook"
        DataSourceID="srcGuestBook"
        DefaultMode="Insert"
        runat="server">
        <InsertItemTemplate>
        <asp:Label
            id="lblName"
            Text="Your Name:"
            AssociatedControlID="txtName"
            Runat="server" />
        <asp:TextBox
            id="txtName"
            Text='<%# Bind("Name") %>'
            Runat="server" />    
        <br /><br />    
        <asp:Label
            id="Label1"
            Text="Your Comments:"
            AssociatedControlID="txtComments"
            Runat="server" />
        <br />    
        <asp:TextBox
            id="txtComments"
            Text='<%# Bind("Comments") %>'
            TextMode="MultiLine"
            Columns="60"
            Rows="4"
            Runat="server" />    
        <br /><br />
        <asp:Button
            id="btnSubmit"
            Text="Submit"
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
        SelectCommand="SELECT * FROM GuestBook ORDER BY Id DESC"
        InsertCommand="INSERT GuestBook (IPAddress,Name,Comments)
            VALUES (@IPAddress,@Name,@Comments)"
        ConnectionString="<%$ ConnectionStrings:GuestBook %>"
        Runat="server">
        <InsertParameters>
            <asp:ControlParameter Name="IPAddress" ControlID="__page" 
                PropertyName="IPAddress" />    
        </InsertParameters>
    </asp:SqlDataSource>
        
    </div>
    </form>
</body>
</html>
