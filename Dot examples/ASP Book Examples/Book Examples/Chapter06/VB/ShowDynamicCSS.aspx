<%@ Page Language="VB" Theme="DynamicSkin" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
    
    Sub btnSubmit_Click(ByVal s As Object, ByVal e As EventArgs)
        grdMovies.CssClass = ddlCssClass.SelectedItem.Text
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Dynamic CSS</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        HeaderStyle-CssClass="Header"
        AlternatingRowStyle-CssClass="Alternating"
        GridLines="none"
        Runat="server" />
        
     <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director FROM Movies"   
        Runat="server" />
    
    <hr />

    <asp:Label
        id="lblCssClass"
        Text="Select Style:"
        AssociatedControlID="ddlCssClass"
        Runat="server" />
    <asp:DropDownList
        id="ddlCssClass"
        Runat="server">
        <asp:ListItem Text="Professional" />
        <asp:ListItem Text="Colorful" />
    </asp:DropDownList>     
    <asp:Button
        id="btnSubmit"
        Text="Select"
        Runat="server" OnClick="btnSubmit_Click" />        
    
    </div>
    </form>
</body>
</html>
