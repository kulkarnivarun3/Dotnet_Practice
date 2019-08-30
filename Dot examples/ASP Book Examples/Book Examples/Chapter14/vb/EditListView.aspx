<%@ Page Language="vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<style type="text/css">

    .movie
    {
       border: solid 1px black;
       padding:5px;
       margin:3px; 
    }

    .edit
    {
        background-color:lightyellow;
    }

</style>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Edit ListView</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:ListView 
            ID="lstMovies"
            DataSourceId="srcMovies"
            DataKeyNames="Id"
            runat="server">
            <LayoutTemplate>
                <asp:Placeholder 
                    id="itemPlaceholder"
                    runat="server" />
            </LayoutTemplate>
            <ItemTemplate>
                <div class="movie">
                <strong><%# Eval("Title") %></strong>
                <br />
                <em>Directed by <%# Eval("Director") %></em>
                <br />
                <asp:LinkButton
                    id="lnkEdit"
                    Text="{Edit}"
                    CommandName="Edit"
                    Runat="server" />
                <asp:LinkButton
                    id="lnkDelete"
                    Text="{Delete}"
                    CommandName="Delete"
                    OnClientClick="return confirm('Delete this movie?')"
                    Runat="server" />
                </div>
            </ItemTemplate>
            <EditItemTemplate>
                <div class="movie edit">
                <asp:Label
                    id="lblTitle"
                    Text="Title:"
                    AssociatedControlID="txtTitle"
                    Runat="server" />
                <br />
                <asp:TextBox
                    id="txtTitle"
                    Text='<%# Bind("Title") %>'
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
                    Text='<%# Bind("Director") %>'
                    Runat="server" />    
                
                <br /><br />
                <asp:LinkButton
                    id="lnkUpdate"
                    Text="Save"
                    CommandName="Update"
                    Runat="server" />
               <asp:LinkButton
                    id="lnkCancel"
                    Text="Cancel"
                    CommandName="Cancel"
                    Runat="server" /> 
                </div>
            </EditItemTemplate>
        </asp:ListView>
    
        <asp:SqlDataSource
            id="srcMovies"
            SelectCommand="SELECT Id, Title, Director FROM Movie"
            UpdateCommand="Update Movie SET Title=@Title, Director=@Director
                WHERE Id=@Id"            
            DeleteCommand="Delete Movie WHERE Id=@Id"    
            ConnectionString='<%$ ConnectionStrings:con %>'
            Runat="server" />
    
    </div>
    </form>
</body>
</html>
