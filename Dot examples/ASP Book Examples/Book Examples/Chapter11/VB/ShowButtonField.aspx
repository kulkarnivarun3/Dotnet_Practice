<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Sub grdMovieCategories_RowCommand(ByVal sender As Object, ByVal e As GridViewCommandEventArgs)
        Dim index As Integer = Int32.Parse(CType(e.CommandArgument, String))
        Dim id As Integer = CType(grdMovieCategories.DataKeys(index).Values("Id"), Integer)
        Dim position As Integer = CType(grdMovieCategories.DataKeys(index).Values("Position"), Integer)
        Select Case e.CommandName
            Case "Up"
                position = position - 1
            Case "Down"
                position = position + 1
        End Select
        srcMovieCategories.UpdateParameters("Id").DefaultValue = id.ToString()
        srcMovieCategories.UpdateParameters("Position").DefaultValue = position.ToString()
        srcMovieCategories.Update()
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show ButtonField</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovieCategories"
        DataSourceID="srcMovieCategories"
        DataKeyNames="Id,Position"
        AutoGenerateColumns="false"
        OnRowCommand="grdMovieCategories_RowCommand"
        Runat="server">
        <Columns>
        <asp:ButtonField
            Text="Move Up"
            CommandName="Up" />
        <asp:ButtonField
            Text="Move Down"
            CommandName="Down" />
        <asp:BoundField
            DataField="Position"
            HeaderText="Position" />
        <asp:BoundField
            DataField="Name"
            HeaderText="Category Name" />
        </Columns>
    </asp:GridView>    
    
    <asp:SqlDataSource
        id="srcMovieCategories"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id, Name, Position FROM MovieCategories
            ORDER BY Position"
        UpdateCommand="UPDATE MovieCategories SET
            Position=@Position WHERE Id=@Id"
        Runat="server">
        <UpdateParameters>
        <asp:Parameter
            Name="Id" />
        <asp:Parameter
            Name="Position" />
        </UpdateParameters>
    </asp:SqlDataSource>        
    
    </div>
    </form>
</body>
</html>
