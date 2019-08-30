<%@ Page Language="VB" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    Protected Sub btnReject_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim movie As New Movie9()
        movie.RejectChanges()
        grdMovies.DataBind()
    End Sub
 
    Protected Sub btnAccept_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim movie As New Movie9()
        movie.AcceptChanges()
        grdMovies.DataBind()
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Movie9</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <h1>Edit Movies</h1>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        DataKeyNames="Id"
        AutoGenerateEditButton="true"
        Runat="server">
        <Columns>
        <asp:TemplateField>
        <ItemTemplate>
        <%#CType(Container.DataItem, DataRowView).Row.RowState.ToString()%>
        </ItemTemplate>
        </asp:TemplateField>
        </Columns>
    </asp:GridView>    
    
    <br />
    
    <asp:Button
        id="btnReject"
        Text="Reject Changes"
        OnClick="btnReject_Click" 
        Runat="server" />
    
    <asp:Button
        id="btnAccept"
        Text="Accept Changes"
        OnClick="btnAccept_Click" 
        Runat="server" />
    
    <asp:ObjectDataSource
        id="srcMovies"
        TypeName="Movie9"
        SelectMethod="GetAll"
        UpdateMethod="Update"
        Runat="server" />    
    
    </div>
    </form>
</body>
</html>
