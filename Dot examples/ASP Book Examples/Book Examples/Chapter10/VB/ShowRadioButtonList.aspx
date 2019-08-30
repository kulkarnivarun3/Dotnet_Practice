<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Protected  Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        lblMovie.Text = rblMovies.SelectedItem.Text
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show RadioButtonList</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:RadioButtonList
        id="rblMovies"
        DataSourceID="srcMovies"
        DataTextField="Title"
        DataValueField="Id"
        RepeatColumns="3"
        Runat="server" />
        
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        Runat="server" OnClick="btnSubmit_Click" />
    
    <hr />
    
    <asp:Label
        id="lblMovie"
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
