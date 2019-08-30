<%@ Page Language="C#" MaintainScrollPositionOnPostback="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void dlstMovies_EditCommand(object source, DataListCommandEventArgs e)
    {
        dlstMovies.EditItemIndex = e.Item.ItemIndex;
        dlstMovies.DataBind();
    }

    protected void dlstMovies_UpdateCommand(object source, DataListCommandEventArgs e)
    {
        // Get form fields
        TextBox txtTitle = (TextBox)e.Item.FindControl("txtTitle");
        TextBox txtDirector = (TextBox)e.Item.FindControl("txtDirector");
        CheckBox chkInTheaters = (CheckBox)e.Item.FindControl("chkInTheaters");

        // Assign parameters
        srcMovies.UpdateParameters["Id"].DefaultValue = dlstMovies.DataKeys[e.Item.ItemIndex].ToString();
        srcMovies.UpdateParameters["Title"].DefaultValue = txtTitle.Text;
        srcMovies.UpdateParameters["Director"].DefaultValue = txtDirector.Text;
        srcMovies.UpdateParameters["InTheaters"].DefaultValue = chkInTheaters.Checked.ToString();

        // Call SqlDataSource Update
        srcMovies.Update();
        
        // Take out of Edit mode
        dlstMovies.EditItemIndex = -1;
    }

    protected void dlstMovies_DeleteCommand(object source, DataListCommandEventArgs e)
    {
        // Assign parameters
        srcMovies.DeleteParameters["Id"].DefaultValue = dlstMovies.DataKeys[e.Item.ItemIndex].ToString();
      
        // Call SqlDataSource Delete
        srcMovies.Delete();
    }

    protected void dlstMovies_CancelCommand(object source, DataListCommandEventArgs e)
    {
        dlstMovies.EditItemIndex = -1;
        dlstMovies.DataBind();
    }
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
