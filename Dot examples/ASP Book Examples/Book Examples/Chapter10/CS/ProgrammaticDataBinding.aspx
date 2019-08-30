<%@ Page Language="C#" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    /// <summary>
    /// Represents an item in the
    /// shopping cart
    /// </summary>
    public class CartItem
    {
        private int _id;
        public string _description;

        public int Id
        {
            get { return _id; }
        }

        public string Description
        {
            get { return _description; }
        }
        
        public CartItem(int id, string description)
        {
            _id = id;
            _description = description;
        }
    }

    void Page_Load()
    {
        if (!IsPostBack)
        {
            // Create shopping cart
            List<CartItem> shoppingCart = new List<CartItem>();
            shoppingCart.Add(new CartItem(1, "Notebook Computer"));
            shoppingCart.Add(new CartItem(2, "HD Plasma Television"));
            shoppingCart.Add(new CartItem(3, "Lava Lamp"));

            // Bind ListBox to shopping cart
            lstShoppingCart.DataSource = shoppingCart;
            lstShoppingCart.DataBind();
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Programmatic DataBinding</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:ListBox
        id="lstShoppingCart"
        DataTextField="Description"
        DataValueField="Id"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
