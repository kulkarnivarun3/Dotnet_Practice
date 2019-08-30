<%@ Page Language="C#" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>


<script runat="server">


    public int BookId
    {
        get { return (int)ViewState["BookId"]; }
        set { ViewState["BookId"] = value; }
    }


    void Page_Load()
    {
        if (!IsPostBack)
        {
            if (String.IsNullOrEmpty(Request["bookId"]))
                Response.Redirect("~/Admin/Books/Edit.aspx");
            BookId = Int32.Parse(Request["BookId"]);
            lnkAdd.NavigateUrl = "Edit.aspx?bookId=" + BookId.ToString();
        }
    }
    
   

    protected void btnNext_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Books/Default.aspx" );
    }

    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Admin/Books/Edit.aspx?bookId=" + BookId.ToString());
    }
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




