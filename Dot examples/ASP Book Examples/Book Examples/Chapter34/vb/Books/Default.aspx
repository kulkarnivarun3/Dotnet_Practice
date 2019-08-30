<%@ Page Language="vb" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>
<%@ Register TagPrefix="user" TagName="ChaptersView" Src="~/UserControls/ChaptersView.ascx"  %>
<script runat="server">

 
    Private  Sub Page_Load()
        lnkAdd.Visible = User.IsInRole("Administrators")
    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">


<asp:ListView
    id="lstBooks"
    DataSourceId="srcBooks"
    DataKeyNames="Id,Version"
    Runat="server">
   
    <LayoutTemplate>
        <div>
        <asp:PlaceHolder 
            id="itemPlaceholder" 
            runat="server" />
        </div>
    </LayoutTemplate>
    <ItemTemplate>
        <h1><%# Eval("Title") %></h1>
        
        <asp:Image
            id="imgBook"
            ImageUrl='<%# Eval("CoverPicture") %>'
            Runat="server" />
        
        <%# Eval("Description") %>
        
        <asp:HyperLink
            id="lnkEdit"
            Text="{Edit}"
            NavigateUrl='<%# Eval("Id", "~/Admin/Books/Edit.aspx?bookId={0}" ) %>'
            Visible='<%# User.IsInRole("Administrators") %>'
            Runat="server" />
        
        <asp:LinkButton
            id="lnkDelete"
            Text="{Delete}"
            CommandName="Delete"
            OnClientClick="return confirm('Are you sure that you want to delete this book?')"
            Visible='<%# User.IsInRole("Administrators") %>'
            runat="server" />        
        
        
        <div class="tocList">
            <h2>Table of Contents</h2>
            
            <user:ChaptersView
                id="ChaptersView1"
                BookId='<%# Eval("Id") %>'
                Runat="Server" />
        </div>
    </ItemTemplate>
</asp:ListView>


<asp:HyperLink
    id="lnkAdd"
    Text="{Add Book}"
    NavigateUrl="~/Admin/Books/Edit.aspx"
    Visible='<%# User.IsInRole("Administrators" ) %>'
    Runat="server" />




<super:EntityDataSource
    id="srcBooks"
    TypeName="Book"
    Runat="server" />



</asp:Content>

