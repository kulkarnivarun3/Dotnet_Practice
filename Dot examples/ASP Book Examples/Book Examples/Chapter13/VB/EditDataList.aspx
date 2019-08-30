<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Protected Sub dlstMovies_EditCommand(ByVal source As Object, ByVal e As DataListCommandEventArgs)
        dlstMovies.EditItemIndex = e.Item.ItemIndex
        dlstMovies.DataBind()
    End Sub
 
    Protected Sub dlstMovies_UpdateCommand(ByVal source As Object, ByVal e As DataListCommandEventArgs)
        ' Get form fields
        Dim txtTitle As TextBox = CType(e.Item.FindControl("txtTitle"), TextBox)
        Dim txtDirector As TextBox = CType(e.Item.FindControl("txtDirector"), TextBox)
        Dim chkInTheaters As CheckBox = CType(e.Item.FindControl("chkInTheaters"), CheckBox)
 
        ' Assign parameters
        srcMovies.UpdateParameters("Id").DefaultValue = dlstMovies.DataKeys(e.Item.ItemIndex).ToString()
        srcMovies.UpdateParameters("Title").DefaultValue = txtTitle.Text
        srcMovies.UpdateParameters("Director").DefaultValue = txtDirector.Text
        srcMovies.UpdateParameters("InTheaters").DefaultValue = chkInTheaters.Checked.ToString()
 
        ' Call SqlDataSource Update
        srcMovies.Update()
 
        ' Take out of Edit mode
        dlstMovies.EditItemIndex = -1
    End Sub
 
    Protected Sub dlstMovies_DeleteCommand(ByVal source As Object, ByVal e As DataListCommandEventArgs)
        ' Assign parameters
        srcMovies.DeleteParameters("Id").DefaultValue = dlstMovies.DataKeys(e.Item.ItemIndex).ToString()
 
        ' Call SqlDataSource Delete
        srcMovies.Delete()
    End Sub
 
    Protected Sub dlstMovies_CancelCommand(ByVal source As Object, ByVal e As DataListCommandEventArgs)
        dlstMovies.EditItemIndex = -1
        dlstMovies.DataBind()
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <style type="text/css">
    html
    {
        background-color:silver;
    }
    .movies
    {
        background-color:white;
    }
    .movies td,.movies th
    {
        padding:10px;
        border:solid 1px black;
    }
    .edit
    {
        background-color:yellow;
    }
    a
    {
        color:blue;
    }
    </style>
    <title>Edit DataList</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DataList
        id="dlstMovies"
        DataSourceID="srcMovies"
        DataKeyField="Id"
        GridLines="None"
        OnEditCommand="dlstMovies_EditCommand"
        OnCancelCommand="dlstMovies_CancelCommand"
        OnUpdateCommand="dlstMovies_UpdateCommand"
        OnDeleteCommand="dlstMovies_DeleteCommand"
        CssClass="movies" 
        EditItemStyle-CssClass="edit"
        Runat="server">
        <ItemTemplate>
        <h1><%#Eval("Title")%></h1>
        Directed by: 
        <%#Eval("Director") %>
        <br />
        In Theaters:
        <%#Eval("InTheaters") %>
        <br /><br />
        <asp:LinkButton
            id="lnkEdit"
            CommandName="Edit"
            Text="Edit"
            Runat="server" />
        &nbsp;|&nbsp;
        <asp:LinkButton
            id="lnkDelete"
            CommandName="Delete"
            Text="Delete"
            OnClientClick="return confirm('Are you sure?');"
            Runat="server" />
        </ItemTemplate>
        <EditItemTemplate>
        <asp:Label
            id="lblTitle"
            Text="Title:"
            AssociatedControlID="txtTitle"
            Runat="server" />
        <br />
        <asp:TextBox
            id="txtTitle"
            Text='<%#Eval("Title")%>'
            Runat="server" />
        <br /><br />
        <asp:Label
            id="lblDirector"
            Text="Director:"
            AssociatedControlID="txtDirector"
            Runat="server" />
        <br />
        <asp:TextBox
            id="txtDirector"
            Text='<%#Eval("Director")%>'
            Runat="server" />
        <br /><br />
        <asp:CheckBox
            id="chkInTheaters"
            Text="In Theaters"
            Checked='<%#Eval("InTheaters")%>'
            Runat="server" />    
        <br /><br />
        <asp:LinkButton
            id="lnkUpdate"
            CommandName="Update"
            Text="Update"
            Runat="server" />
         &nbsp;|&nbsp;           
        <asp:LinkButton
            id="lnkCancel"
            CommandName="Cancel"
            Text="Cancel"
            Runat="server" />
        </EditItemTemplate>
    </asp:DataList>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director,InTheaters
            FROM Movies"
        UpdateCommand="UPDATE Movies SET Title=@Title,
            Director=@Director,InTheaters=@InTheaters
            WHERE Id=@Id"
        DeleteCommand="DELETE Movies WHERE Id=@Id"    
        Runat="server">
        <UpdateParameters>
            <asp:Parameter Name="Id" />
            <asp:Parameter Name="Title" />
            <asp:Parameter Name="Director" />
            <asp:Parameter Name="InTheaters" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
    </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
