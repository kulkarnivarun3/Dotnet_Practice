<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    /// <summary>
    /// When button clicked, execute Insert command
    /// </summary>
    protected void btnAddEntry_Click(object sender, EventArgs e)
    {
        srcGuestBook.InsertParameters["Name"].DefaultValue = txtName.Text;
        srcGuestBook.InsertParameters["Comments"].DefaultValue = txtComments.Text;
        srcGuestBook.Insert();
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Execute Insert</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblName"
        Text="Name:"
        AssociatedControlId="txtName"
        Runat="server" />
    <br />    
    <asp:TextBox 
        id="txtName"
        Runat="server" />
    
    <br /><br />
    
    <asp:Label
        id="lblComments"
        Text="Comments:"
        AssociatedControlId="txtComments"
        Runat="server" />
    <br />    
    <asp:TextBox 
        id="txtComments"
        TextMode="MultiLine"
        Columns="50"
        Rows="2"
        Runat="server" />
    
    <br /><br />
    
    <asp:Button
        id="btnAddEntry"
        Text="Add Entry"
        Runat="server" OnClick="btnAddEntry_Click" />
    
    <hr />
    
    <asp:GridView
        id="grdGuestBook"
        DataSourceId="srcGuestBook"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcGuestBook"
        ConnectionString="<%$ ConnectionStrings:GuestBook %>"
        SelectCommand="SELECT Name,Comments FROM GuestBook
            ORDER BY Id DESC"
        InsertCommand="INSERT GuestBook (Name,Comments)
            VALUES (@Name,@Comments)"
        Runat="server">
        <InsertParameters>
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="Comments" />
        </InsertParameters>
    </asp:SqlDataSource>    
    
    
    </div>
    </form>
</body>
</html>
