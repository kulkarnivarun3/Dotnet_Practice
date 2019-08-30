<%@ Page Language="VB" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    Sub Page_Load()
        ' Create the DataTable columns
        Dim NewDataTable As New DataTable()
        NewDataTable.Columns.Add("Id", GetType(Integer))
        NewDataTable.Columns.Add("ProductName", GetType(String))
        NewDataTable.Columns.Add("ProductPrice", GetType(Decimal))
 
        ' Mark the Id column as an autoincrement column
        NewDataTable.Columns("Id").AutoIncrement = True
 
        ' Add some data rows
        For i As Integer = 1 To 10
            Dim NewRow As DataRow = NewDataTable.NewRow()
            NewRow("ProductName") = "Product " & i.ToString()
            NewRow("ProductPrice") = 12.34
            NewDataTable.Rows.Add(NewRow)
        Next
 
        ' Bind DataTable to GridView
        grdProducts.DataSource = NewDataTable
        grdProducts.DataBind()
    End Sub
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
