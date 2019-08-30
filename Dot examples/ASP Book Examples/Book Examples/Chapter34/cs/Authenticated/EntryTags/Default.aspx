<%@ Page Language="C#" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>

<script runat="server">


    public int EntryId
    {
        get { return (int)ViewState["EntryId"]; }
        set { ViewState["EntryId"] = value; }
    }

    void Page_Load()
    {
        if (!IsPostBack)
        {
            if (String.IsNullOrEmpty(Request["entryId"]))
                Response.Redirect("~/Authenticated/Entries/Add.aspx");
            EntryId = Int32.Parse(Request["EntryId"]);
        }
    }


    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Authenticated/CodeSamples/Default.aspx?entryId=" + EntryId.ToString());
    }

    protected void srcTags_Inserting(object sender, ObjectDataSourceMethodEventArgs e)
    {
        EntryTag tag = (EntryTag)e.InputParameters[0];
        tag.EntryId = EntryId;
    }


    protected void frmInsert_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            e.KeepInInsertMode = true;
            ValidationUtility.ShowValidationErrors(this, e.Exception);
        }
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/CodeSamples/Entry.aspx?entryId=" + EntryId.ToString());
    }


    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static string[] GetSuggestions(string prefixText, int count)
    {
        return EntryTag.GetSuggestions(prefixText, count);
    }

    
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">


    <asp:FormView 
        ID="frmInsert"
        DataSourceID="srcTags"
        DefaultMode="Insert"
        runat="server" OnItemInserted="frmInsert_ItemInserted">
        <InsertItemTemplate>
        
        
        <super:EntityValidator
            id="valAuthorUserName"
            PropertyName="AuthorUserName"
            CssClass="errorMessage"
            Runat="server" />
        
        <asp:Label
            id="lblTag"
            Text="Tag:"
            AssociatedControlID="txtTag"
            Runat="server" />
        <asp:TextBox
            id="txtTag"
            Text='<%# Bind("Name") %>'
            Runat="server" />
        <ajaxToolkit:AutoCompleteExtender 
            ID="AutoCompleteExtender1"
            ServiceMethod="GetSuggestions"
            TargetControlID="txtTag"
            MinimumPrefixLength="1"
            Runat="server" />
        <asp:Button
            id="btnInsert"
            Text="Add Tag"
            CommandName="Insert"
            Runat="server" />
        <super:EntityCallOutValidator
            id="valName"
            PropertyName="Name"
            Runat="server" />    

        </InsertItemTemplate>
    </asp:FormView>


    <asp:GridView
        id="grdTags"
        DataSourceId="srcTags"
        DataKeyNames="Id,EntryId,Version"
        AutoGenerateColumns="false"
        ShowHeader="false"
        Runat="server">
        <Columns>
        <asp:TemplateField>
        <ItemTemplate>
            <asp:LinkButton
                id="lnkDelete"
                Text="Delete"
                CommandName="Delete"
                OnClientClick="return confirm('Delete tag?')"
                Runat="server" />
        </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Name" />
        </Columns>
    </asp:GridView>    





    <super:EntityDataSource
        id="srcTags"
        TypeName="EntryTag"
        SelectMethod="SelectByEntryId"
        OnInserting="srcTags_Inserting"
        Runat="server" >
        <SelectParameters>
            <asp:QueryStringParameter Name="entryId" QueryStringField="entryId" />
        </SelectParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="entryId" QueryStringField="entryId" />
        </InsertParameters>
    </super:EntityDataSource>


<div class="divWizardButtons">
    <asp:Button
        id="btnPrevious"
        Text="Previous"
        Runat="server" OnClick="btnPrevious_Click" />
    
    <asp:Button
        id="btnFinish"
        Text="Finish"
        Runat="server" OnClick="btnFinish_Click" />

</div>

</asp:Content>


