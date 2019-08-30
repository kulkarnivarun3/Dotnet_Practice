<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        if (!Page.IsPostBack)
        {
            // Create collection of items
            ArrayList items = new ArrayList();
            items.Add("Apples");
            items.Add("Oranges");

            // Bind to DropDownList
            DropDownList1.DataSource = items;
            DropDownList1.DataBind();
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Label1.Text = DropDownList1.SelectedItem.Text;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show IsPostBack</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DropDownList
        id="DropDownList1"
        Runat="server" />
    
    <asp:Button
        id="Button1"
        Text="Select"
        OnClick="Button1_Click" 
        Runat="server" />
    
    <br /><br />

    You selected:
    <asp:Label  
        id="Label1"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
