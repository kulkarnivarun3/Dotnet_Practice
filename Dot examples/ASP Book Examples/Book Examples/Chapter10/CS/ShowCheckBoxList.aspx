<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        foreach (ListItem item in cblMovies.Items)
            if (item.Selected)
                lblMovie.Text += "<li>" + item.Text;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show CheckBoxList</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:CheckBoxList
        id="cblMovies"
        DataSourceID="srcMovies"
        DataTextField="Title"
        DataValueField="Id"
        RepeatColumns="2"
        Runat="server" />
    
    <p>    
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        OnClick="btnSubmit_Click" 
        Runat="server" />
    </p>
    
    <hr />
    
    <asp:Label
        id="lblMovie"
        EnableViewState="false"
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
