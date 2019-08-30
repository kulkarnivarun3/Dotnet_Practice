<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void btnElephant_Click(object sender, ImageClickEventArgs e)
    {
        lblX.Text = e.X.ToString();
        lblY.Text = e.Y.ToString(); 
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show EventArgs</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:ImageButton
        id="btnElephant"
        ImageUrl="Elephant.jpg"
        Runat="server" OnClick="btnElephant_Click" />
    
    <br />
    X Coordinate:
    <asp:Label
        id="lblX"
        Runat="server" />
    <br />
    Y Coordinate:
    <asp:Label
        id="lblY"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
