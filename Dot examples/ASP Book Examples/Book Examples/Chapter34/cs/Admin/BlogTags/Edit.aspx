<%@ Page Language="C#" MasterPageFile="~/Design/MasterPage.master" Title="Edit Blog Tags" %>

<script runat="server">


    void Page_Load()
    {
        if (!IsPostBack)
        {
            if (String.IsNullOrEmpty(Request["blogId"]))
                Response.Redirect("~/Admin/Blog/Edit.aspx");
        }
    }


    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Admin/Blog/Edit.aspx?blogId=" + Request["blogId"]);
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Blog/Default.aspx?blogId=" + Request["blogId"] );
    }

    protected void srcTags_Inserting(object sender, ObjectDataSourceMethodEventArgs e)
    {
        BlogTag newTag = (BlogTag)e.InputParameters[0];
        newTag.BlogId = Int32.Parse(Request["blogId"]);
    }

    protected void srcTags_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
    {
        if (e.Exception != null)
        {
            ValidationUtility.ShowValidationErrors(this, e.Exception);
        }    
    }

    protected void frmInsert_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            e.KeepInInsertMode = true;
        }
    }
    
    
    [System.Web.Services.WebMethod]
    public static string[] GetSuggestions(string prefixText, int count) 
    {
        return BlogTag.GetSuggestions(prefixText, count);
    }
    
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">


    <asp:FormView 
        ID="frmInsert"
        DataSourceID="srcTags"
        DefaultMode="Insert"
        runat="server" OnItemInserted="frmInsert_ItemInserted">
    <InsertItemTemplate>
    <asp:Label
        id="lblTag"
        Text="Tag:"
        AssociatedControlID="txtTag"
        Runat="server" />
    <asp:TextBox
        id="txtTag"
        AutoComplete="Off"
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
        DataKeyNames="Id,Version"
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
        TypeName="BlogTag"
        SelectMethod="SelectByBlogId"
        Runat="server" OnInserting="srcTags_Inserting" OnInserted="srcTags_Inserted">
        <SelectParameters>
            <asp:QueryStringParameter Name="BlogId" QueryStringField="blogId" />
        </SelectParameters>
    </super:EntityDataSource>


<div class="divWizardButtons">
 
    <asp:Button
        id="btnPrevious"
        Text="Previous"
        OnClick="btnPrevious_Click" 
        Runat="server" />
    
    <asp:Button
        id="btnFinish"
        Text="Finish"
        OnClick="btnFinish_Click" 
        Runat="server" />

</div>

</asp:Content>


