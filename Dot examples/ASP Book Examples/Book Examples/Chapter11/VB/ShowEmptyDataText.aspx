<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    Sub btnSubmit_Click(sender As object, e As EventArgs)
        grdMovies.Visible = True
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Empty Data Text</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:TextBox
        id="txtTitle"
        Runat="server" />
    <asp:Button
        id="btnSubmit"
        Text="Search"
        OnClick="btnSubmit_Click"
        Runat="server" />
    <hr />
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        EmptyDataText="<img src='sad.gif'/> No Matching Movies!"
        Visible="false"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Title,Director FROM Movies
            WHERE Title LIKE @Title+'%'"
        Runat="server">
        <SelectParameters>
        <asp:ControlParameter
            Name="Title"
            ControlID="txtTitle"
            PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
