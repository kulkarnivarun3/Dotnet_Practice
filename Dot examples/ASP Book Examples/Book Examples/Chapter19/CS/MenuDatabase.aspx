<%@ Page Language="C#" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
   

    /// <summary>
    /// Only populate the menu when the page first loads
    /// </summary>
    void Page_Load()
    {
        if (!Page.IsPostBack)
            PopulateMenu();
    }

    /// <summary>
    /// Get the data from the database and create the top-level
    /// menu items
    /// </summary>
    private void PopulateMenu()
    {
        DataTable menuData = GetMenuData();
        AddTopMenuItems(menuData);
    }
    
    /// <summary>
    /// Use a DataAdapter and DataTable to grab the database data
    /// </summary>
    /// <returns></returns>
    private DataTable GetMenuData()    
    {
        // Get Categories table
        string selectCommand = "SELECT CategoryId,ParentId,Name FROM Categories";
        string conString = WebConfigurationManager.ConnectionStrings["Categories"].ConnectionString;
        SqlDataAdapter dad = new SqlDataAdapter(selectCommand, conString);
        DataTable dtblCategories = new DataTable();
        dad.Fill(dtblCategories);
        return dtblCategories;
    }

    /// <summary>
    /// Filter the data to get only the rows that have a
    /// null ParentID (these are the top-level menu items)
    /// </summary>
    private void AddTopMenuItems(DataTable menuData)
    {
        DataView view = new DataView(menuData);
        view.RowFilter = "ParentID IS NULL";
        foreach (DataRowView row in view)
        {
            MenuItem newMenuItem = new MenuItem(row["Name"].ToString(), row["CategoryId"].ToString());
            Menu1.Items.Add(newMenuItem);
            AddChildMenuItems(menuData, newMenuItem);
        }

    }

    /// <summary>
    /// Recursively add child menu items by filtering by ParentID
    /// </summary>
    private void AddChildMenuItems(DataTable menuData, MenuItem parentMenuItem)
    {
        DataView view = new DataView(menuData);
        view.RowFilter = "ParentID=" + parentMenuItem.Value;
        foreach (DataRowView row in view)
        {
            MenuItem newMenuItem = new MenuItem(row["Name"].ToString(), row["CategoryId"].ToString());
            parentMenuItem.ChildItems.Add(newMenuItem);
            AddChildMenuItems(menuData, newMenuItem);
        }
    }
    
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
