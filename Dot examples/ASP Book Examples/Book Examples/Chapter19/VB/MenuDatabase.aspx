<%@ Page Language="VB" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    ''' <summary>
    ''' Only populate the menu when the page first loads
    ''' </summary>
    Private Sub Page_Load()
        If Not Page.IsPostBack Then
            PopulateMenu()
        End If
    End Sub
 
    ''' <summary>
    ''' Get the data from the database and create the top-level
    ''' menu items
    ''' </summary>
    Private Sub PopulateMenu()
        Dim menuData As DataTable = GetMenuData()
        AddTopMenuItems(menuData)
    End Sub
 
    ''' <summary>
    ''' Use a DataAdapter and DataTable to grab the database data
    ''' </summary>
    ''' <returns></returns>
    Private Function GetMenuData() As DataTable
        ' Get Categories table
        Dim selectCommand As String = "SELECT CategoryId,ParentId,Name FROM Categories"
        Dim conString As String = WebConfigurationManager.ConnectionStrings("Categories").ConnectionString
        Dim dad As SqlDataAdapter = New SqlDataAdapter(selectCommand, conString)
        Dim dtblCategories As DataTable = New DataTable()
        dad.Fill(dtblCategories)
        Return dtblCategories
    End Function
 
    ''' <summary>
    ''' Filter the data to get only the rows that have a
    ''' null ParentID (these are the top-level menu items)
    ''' </summary>
    Private Sub AddTopMenuItems(ByVal menuData As DataTable)
        Dim view As DataView = New DataView(menuData)
        view.RowFilter = "ParentID IS NULL"
        Dim row As DataRowView
        For Each row In view
            Dim NewMenuItem As MenuItem = New MenuItem(row("Name").ToString(), row("CategoryId").ToString())
            Menu1.Items.Add(NewMenuItem)
            AddChildMenuItems(menuData, NewMenuItem)
        Next
 
    End Sub
 
    ''' <summary>
    ''' Recursively add child menu items by filtering by ParentID
    ''' </summary>
    Private Sub AddChildMenuItems(ByVal menuData As DataTable, ByVal parentMenuItem As MenuItem)
        Dim view As DataView = New DataView(menuData)
        view.RowFilter = "ParentID=" + parentMenuItem.Value
        Dim row As DataRowView
        For Each row In view
            Dim NewMenuItem As MenuItem = New MenuItem(row("Name").ToString(), row("CategoryId").ToString())
            parentMenuItem.ChildItems.Add(NewMenuItem)
            AddChildMenuItems(menuData, NewMenuItem)
        Next
    End Sub
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .menuItem
        {
            border:Solid 1px black;
            width:100px;
            padding:2px;
            background-color:#eeeeee;
        }
        .menuItem a
        {
            color:blue;
        }
        .grid
        {
            margin-top:10px;
        }
        
        .grid td, .grid th
        {
            padding:10px;
        }
    </style>
    <title>Menu Database</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Menu
        id="Menu1"
        Orientation="horizontal"
        StaticMenuItemStyle-CssClass="menuItem"
        DynamicMenuItemStyle-CssClass="menuItem"
        Runat="server" />

    <asp:GridView
        id="grdProducts"
        DataSourceID="srcProducts"
        CssClass="grid"
        AutoGenerateColumns="false"
        Runat="server">
        <Columns>
        <asp:BoundField
            DataField="ProductName"
            HeaderText="Product" />
        <asp:BoundField
            DataField="Price"
            HeaderText="Price"
            DataFormatString="{0:c}" />    
        </Columns>
    </asp:GridView>    
        
    <asp:SqlDataSource
        id="srcProducts"
        ConnectionString="<%$ ConnectionStrings:Categories %>"
        SelectCommand="SELECT ProductName,Price FROM Products
            WHERE CategoryId=@CategoryId"
        Runat="server">
        <SelectParameters>
        <asp:ControlParameter 
            Name="CategoryId"
            ControlID="Menu1" />
        </SelectParameters>
    </asp:SqlDataSource>        
    
    
    </div>
    </form>
</body>
</html>
