<%@ Page Language="VB" %>
<%@ Register TagPrefix="custom" Namespace="MyControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    Public ReadOnly Property CurrentUsername() As String
        Get
            Return User.Identity.Name
        End Get
    End Property
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <style type="text/css">
        .guestbook td,.guestbook th
        {
            padding:5px;
            font:14px Arial,Sans-Serif;
        }
    </style>
    <title>Show Page Property Parameter</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:FormView
        id="frmGuestbook"
        DataSourceID="srcGuestbook"
        DefaultMode="Insert"
        Runat="server">
        <InsertItemTemplate>
        <asp:Label
            ID="lblComment"
            Text="Comment:"
            AssociatedControlID="txtComment"
            Runat="server" />
        <br />
        <asp:TextBox
            id="txtComment"
            Text='<%# Bind("comment") %>'
            TextMode="MultiLine"
            Columns="50"
            Rows="4"
            Runat="server" />    
        <br />
        <asp:Button
            id="btnInsert"
            Text="Add Entry"
            CommandName="Insert"
            Runat="server" /> 
        </InsertItemTemplate>
    </asp:FormView>
    
    <hr />
    
    <asp:GridView
        id="grdGuestbook"
        DataSourceID="srcGuestbook"
        CssClass="guestbook"
        Runat="server" />
    
    <asp:ObjectDataSource
        id="srcGuestbook"
        TypeName="GuestbookComponent"
        SelectMethod="GetEntries"
        InsertMethod="AddEntry"
        Runat="server">
        <InsertParameters>
        <custom:PagePropertyParameter 
            Name="Username" 
            PropertyName="CurrentUsername" />
        </InsertParameters>
    </asp:ObjectDataSource>
    
    </div>
    </form>
</body>
</html>
