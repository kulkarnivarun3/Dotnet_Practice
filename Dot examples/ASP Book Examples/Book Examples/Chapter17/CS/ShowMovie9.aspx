<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void btnReject_Click(object sender, EventArgs e)
    {
        Movie9 movie = new Movie9();
        movie.RejectChanges();
        grdMovies.DataBind();
    }

    protected void btnAccept_Click(object sender, EventArgs e)
    {
        Movie9 movie = new Movie9();
        movie.AcceptChanges();
        grdMovies.DataBind();
    }
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
        <%# ((DataRowView)Container.DataItem).Row.RowState %>
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
