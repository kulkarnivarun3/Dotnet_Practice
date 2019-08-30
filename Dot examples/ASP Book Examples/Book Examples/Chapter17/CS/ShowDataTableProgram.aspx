<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        // Create the DataTable columns
        DataTable newDataTable = new DataTable();
        newDataTable.Columns.Add("Id", typeof(int));
        newDataTable.Columns.Add("ProductName", typeof(string));
        newDataTable.Columns.Add("ProductPrice", typeof(decimal));

        // Mark the Id column as an autoincrement column
        newDataTable.Columns["Id"].AutoIncrement = true;
        
        // Add some data rows
        for (int i = 1; i < 11; i++)
        {
            DataRow newRow = newDataTable.NewRow();
            newRow["ProductName"] = "Product " + i.ToString();
            newRow["ProductPrice"] = 12.34m;
            newDataTable.Rows.Add(newRow);
        }
        
        // Bind DataTable to GridView
        grdProducts.DataSource = newDataTable;
        grdProducts.DataBind();
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show DataTable Programmatically</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <h1>Products</h1>
    
    <asp:GridView
        id="grdProducts"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
