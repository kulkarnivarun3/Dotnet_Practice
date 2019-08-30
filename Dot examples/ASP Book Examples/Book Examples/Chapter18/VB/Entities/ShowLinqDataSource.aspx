<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Show LinqDataSource</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblSearch"
        AssociatedControlID="txtSearch"
        Text="Search:"
        Runat="server" />
    <asp:TextBox
        id="txtSearch"
        Runat="server" />
    <asp:Button
        id="btnSearch"
        Text="Search"
        Runat="server" />
    
    <br /><br />    
    
    <asp:GridView
        id="grd"
        DataSourceID="LinqDataSource1" 
        Runat="server" />

        <asp:LinqDataSource 
            ID="LinqDataSource1" 
            ContextTypeName="MyDatabaseDataContext"
            TableName="Movies" 
            Where="Director == @Director"
            OrderBy="DateReleased" 
            Select="new (Title, Director)" 
            runat="server"> 
            <whereparameters>
                <asp:controlparameter 
                    Name="Director" 
                    ControlID="txtSearch" 
                    PropertyName="Text" 
                    Type="String" />
            </whereparameters>
        </asp:LinqDataSource>
    
    </div>
    </form>
</body>
</html>
