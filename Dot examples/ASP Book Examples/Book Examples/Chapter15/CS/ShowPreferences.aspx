<%@ Page Language="C#" trace="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
    
    void Page_PreRender()
    {
        body1.Style["background-color"] = Preferences.FavoriteColor;
    }

    protected void btnSelect_Click(object sender, EventArgs e)
    {
        Preferences.FavoriteColor = ddlFavoriteColor.SelectedItem.Text;
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .content
        {
            width:80%;
            padding:20px;
            background-color:white;
        }
    </style>    
    <title>Show Preferences</title>
</head>
<body id="body1" runat="server">
    <form id="form1" runat="server">
    <div class="content">
    
    <h1>Show Preferences</h1>
    
    <asp:DropDownList
        id="ddlFavoriteColor"
        Runat="server">
        <asp:ListItem Text="Blue" />
        <asp:ListItem Text="Red" />
        <asp:ListItem Text="Green" />
    </asp:DropDownList>
    <asp:Button
        id="btnSelect"
        Text="Select"
        Runat="server" OnClick="btnSelect_Click" />    
    
    </div>
    </form>
</body>
</html>
