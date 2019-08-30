<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    /// <summary>
    /// Move item from All Movies to Favorite Movies
    /// </summary>
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        ListItem item = lstAllMovies.SelectedItem;
        if (item != null)
        {
            lstAllMovies.Items.Remove(item);
            lstFavoriteMovies.ClearSelection();
            lstFavoriteMovies.Items.Add(item);
        }
    }

    /// <summary>
    /// Move item from Favorite Movies to All Movies
    /// </summary>
    protected void btnRemove_Click(object sender, EventArgs e)
    {
        ListItem item = lstFavoriteMovies.SelectedItem;
        if (item != null)
        {
            lstFavoriteMovies.Items.Remove(item);
            lstAllMovies.ClearSelection();
            lstAllMovies.Items.Add(item);
        }
    }

    /// <summary>
    /// When the form is submitted,
    /// show the contents of the
    /// Favorite Movies ListBox
    /// </summary>
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        foreach (ListItem item in lstFavoriteMovies.Items)
            lblResults.Text += "<li>" + item.Text;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .listPicker
        {
            border:solid 1px black;
            padding:5px;
            width:380px;
            background-color:silver;
        }
        .listPicker select
        {
            width:100%;
        }
    </style>
    <title>List Picker</title>
</head>
<body>
    <form id="form1" runat="server">
    
    
    <div class="listPicker">
    <div style="float:left;width:40%">
    <asp:ListBox
        id="lstAllMovies"
        DataSourceID="srcMovies"
        DataTextField="Title"
        DataValueField="Id"
        Runat="server" />
    </div>
    <div style="float:left;width:20%;text-align:center">
    <asp:Button
        id="btnAdd"
        Text="--&gt;"
        ToolTip="Add List Item"
        Runat="server" OnClick="btnAdd_Click" />
    <br />
    <asp:Button
        id="btnRemove"
        Text="&lt;--"
        ToolTip="Remove List Item"
        Runat="server" OnClick="btnRemove_Click" />
    </div>
    <div style="float:left;width:40%">
    <asp:ListBox
        id="lstFavoriteMovies"
        Runat="server" />
    </div>
    <br style="clear:both" />
    </div>
    
    <p>
    <asp:Button
        id="btnSubmit"
        Text="Submit Form"
        Runat="server" OnClick="btnSubmit_Click" />
    </p>

    <hr />
    
    <asp:Label
        id="lblResults"
        EnableViewState="false"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        SelectCommand="SELECT Id, Title FROM Movies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        Runat="server" />
    
    </form>
</body>
</html>
