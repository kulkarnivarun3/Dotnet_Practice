<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void ddlMovies_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblSelectedMovie.Text = ddlMovies.SelectedItem.Text;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>AutoPostBack List Control</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DropDownList
        id="ddlMovies"
        DataSourceID="srcMovies"
        DataTextField="Title"
        DataValueField="Id"
        AutoPostBack="true"
        OnSelectedIndexChanged="ddlMovies_SelectedIndexChanged" 
        Runat="server" />

    <br /><br />

    <asp:Label
        id="lblSelectedMovie"
        Runat="server" />

    <asp:SqlDataSource
        id="srcMovies"
        SelectCommand="SELECT Id, Title FROM Movies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        Runat="server" />

    </div>
    </form>
</body>
</html>
