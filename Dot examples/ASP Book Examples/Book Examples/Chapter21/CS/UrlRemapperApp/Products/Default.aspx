<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    void Page_Load()
    {
        if (!Page.IsPostBack)
        {
            string category = Path.GetFileNameWithoutExtension(Request.RawUrl);
            ltlCategory.Text = category;
            srcProducts.SelectParameters["Category"].DefaultValue = category;
        }        
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .grid td,.grid th
        {
            padding:4px;
            border-bottom:solid 1px black;
        }
    </style>
    <title>Products</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <h1>
    <asp:Literal 
        ID="ltlCategory" 
        runat="server" />
    </h1>

    <asp:GridView
        id="grdProducts"
        DataSourceID="srcProducts"
        CssClass="grid"
        GridLines="None"
        AutoGenerateColumns="false"
        Runat="server">
        <Columns>
        <asp:BoundField 
            HeaderText="Product Name"
            DataField="Name" />
        <asp:BoundField
            HeaderText="Price"
            DataField="Price"
            DataFormatString="{0:c}" />    
        </Columns>
    </asp:GridView>    
        

    <asp:SqlDataSource
        id="srcProducts"
        ConnectionString="<%$ ConnectionStrings:Products %>"
        SelectCommand="SELECT Products.* FROM Products
            JOIN Categories ON Products.CategoryId=Categories.Id
            WHERE Categories.Name=@Category"
        Runat="server">
        <SelectParameters>
        <asp:Parameter Name="Category" />
        </SelectParameters>
    </asp:SqlDataSource>    

    
    </div>
    </form>
</body>
</html>
