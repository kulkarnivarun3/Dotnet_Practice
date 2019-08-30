<%@ Page Language="vb" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>


<script runat="server">

 
    Public Property BookId() As Integer
        Get
            Return CType(ViewState("BookId"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("BookId") = value
        End Set
    End Property
 
 
    Private Sub Page_Load()
        If Not IsPostBack Then
            If String.IsNullOrEmpty(Request("bookId")) Then
                Response.Redirect("~/Admin/Books/Edit.aspx")
            End If
            BookId = Int32.Parse(Request("BookId"))
            lnkAdd.NavigateUrl = "Edit.aspx?bookId=" & BookId.ToString()
        End If
    End Sub
 
 
 
    Protected Sub btnNext_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("~/Books/Default.aspx")
    End Sub
 
    Protected Sub btnPrevious_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("~/Admin/Books/Edit.aspx?bookId=" & BookId.ToString())
    End Sub

</script>


<asp:Content ID="Content" ContentPlaceHolderID="cphMain" runat="server">
<asp:Panel ID="Panel1" DefaultButton="btnNext" runat="server">  
    <asp:GridView
        id="grdChapters"
        DataKeyNames="Id,Version"
        DataSourceID="srcChapters"
        AutoGenerateColumns="false"
        Runat="server">
        <EmptyDataTemplate>
            You have not added any chapters. To add a new chapter,
            click Add Chapter.
        </EmptyDataTemplate>
        <Columns>
        <asp:TemplateField>
        <ItemTemplate>
            <asp:LinkButton
                id="lnkDelete"
                Text="Delete"
                CommandName="Delete"
                OnClientClick="return confirm('Delete chapter?');"
                Runat="server" />
        </ItemTemplate>
        </asp:TemplateField>
        <asp:HyperLinkField DataNavigateUrlFields="BookId,Id" DataNavigateUrlFormatString="Edit.aspx?bookId={0}&chapterId={1}" Text="Edit" />
        <asp:BoundField DataField="Title" />
        </Columns>    
    </asp:GridView>
    
    
    <super:EntityDataSource
        id="srcChapters"
        TypeName="Chapter"
        SelectMethod="SelectByBookId"
        Runat="server">
        <SelectParameters>
            <asp:QueryStringParameter Name="bookId" QueryStringField="bookId" />
        </SelectParameters>
    </super:EntityDataSource>    
    
    <br />
    
    <asp:HyperLink
        id="lnkAdd"
        Text="Add Chapter"
        Runat="server" />
    
    
<div>
    <br />
    <asp:Button
        id="btnPrevious"
        Text="Previous"
        OnClick="btnPrevious_Click" 
        Runat="server" />

    <asp:Button
        id="btnNext"
        Text="Next"
        OnClick="btnNext_Click" 
        Runat="server" />
</div>    
</asp:Panel>    
    
</asp:Content>




