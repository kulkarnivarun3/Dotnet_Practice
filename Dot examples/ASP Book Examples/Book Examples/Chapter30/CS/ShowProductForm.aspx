<%@ Page Language="C#" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    void Page_Load()
    {
        if (!Page.IsPostBack)
        {
            ProductForm1.Name = "Laptop";
            ProductForm1.Price = 433.12m;
            ProductForm1.DataBind();
        }
    }

    protected void ProductForm1_ProductUpdated(object sender, EventArgs e)
    {
        lblName.Text = ProductForm1.Results["Name"].ToString();
        lblPrice.Text = ProductForm1.Results["Price"].ToString();
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show ProductForm</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <custom:ProductForm
        id="ProductForm1"
        Runat="server" OnProductUpdated="ProductForm1_ProductUpdated">
        <EditItemTemplate>
        
        <asp:Label
            id="lblName"
            Text="Product Name:"
            AssociatedControlID="txtName"
            Runat="server" />
        <asp:TextBox
            id="txtName"
            Text='<%# Bind("Name") %>'
            Runat="server" />
        <br /><br />
        <asp:Label
            id="lblPrice"
            Text="Product Price:"
            AssociatedControlID="txtPrice"
            Runat="server" />
        <asp:TextBox
            id="txtPrice"
            Text='<%# Bind("Price") %>'
            Runat="server" />
        <br /><br />
        <asp:Button
            id="btnUpdate"
            Text="Update"
            Runat="server" />
        
        </EditItemTemplate>
    </custom:ProductForm>    
        
    <hr />
    New Product Name:
    <asp:Label
        id="lblName"
        Runat="server" />
    
    <br /><br />    
            
    New Product Price:
    <asp:Label
        id="lblPrice"
        Runat="server" />
        
    </div>
    </form>
</body>
</html>
