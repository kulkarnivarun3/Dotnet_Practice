<%@ Page Language="C#" MasterPageFile="~/Design/MasterPage.master" Title="Edit Comment" %>

<script runat="server">

    protected void srcBlogComments_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        // If new blog comment entry, get title from Blog
        BlogComment newBlogComment = (BlogComment)e.ReturnValue;
        if (newBlogComment.Id == 0)
        {
            Blog blog = Blog.Get(Int32.Parse(Request["blogId"]));
            newBlogComment.Title = "RE: " + blog.Title;
        }
    }

    protected void srcBlogComments_Updating(object sender, ObjectDataSourceMethodEventArgs e)
    {
        // If new blog comment, add user name and blog id
        BlogComment newBlogComment = (BlogComment)e.InputParameters[1];
        if (newBlogComment.Id == 0)
        {
            newBlogComment.AuthorUserName = User.Identity.Name;
            newBlogComment.BlogId = Int32.Parse(Request["blogId"]);
        }
    }

    protected void srcBlogComments_Updated(object sender, ObjectDataSourceStatusEventArgs e)
    {
        BlogComment newBlogComment = (BlogComment)e.ReturnValue;
        if (newBlogComment != null && newBlogComment.IsValid)
            Response.Redirect("~/Blog/Default.aspx?blogId=" + newBlogComment.BlogId);
    }


    protected void frmBlogComment_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            
            ValidationUtility.ShowValidationErrors(this, e.Exception);
        }
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

<asp:UpdatePanel ID="up1" runat="server">
<ContentTemplate>

<asp:FormView
    id="frmBlogComment"
    DataSourceID="srcBlogComments"
    DataKeyNames="Id,Version,BlogId"
    DefaultMode="Edit"
    OnItemUpdated="frmBlogComment_ItemUpdated"
    Runat="server">
    <EditItemTemplate>

    <div class="field">
        <div class="fieldLabel">
        <asp:Label
            id="lblTitle"
            AssociatedControlID="txtTitle"
            Text="Title:"
            Runat="server" />
        </div>
        <div class="fieldValue">    
        <asp:TextBox
            id="txtTitle"
            Columns="50"
            Text='<%# Bind("Title") %>'
            Runat="server" />    
        </div>
        <div class="fieldValue">
        <super:EntityCallOutValidator
            id="valTitle"
            PropertyName="Title"
            Runat="server" />
        </div>    
    </div>    
    

    <div class="field">
        <div class="fieldLabel">
        <asp:Label
            id="lblComment"
            AssociatedControlID="txtComment"
            Text="Comment:"
            Runat="server" />
        </div>
        <div class="fieldValue">
        <asp:TextBox
            id="txtComment"
            Text='<%# Bind("Comment") %>'
            TextMode="MultiLine"
            Columns="50"
            Rows="3"
            Runat="server" />    
        </div>
        <div class="fieldValue">
        <super:EntityCallOutValidator
            id="valComment"
            PropertyName="Comment"
            Runat="server" />
        </div>
    </div>
    
    <br style="clear:both" />    
    <asp:Button
        id="btnUpdate"
        CommandName="Update"
        Text="Save"
        Runat="server" />
    
    </EditItemTemplate>    
</asp:FormView>

</ContentTemplate>
</asp:UpdatePanel>

<super:EntityDataSource
    id="srcBlogComments"
    TypeName="BlogComment"
    SelectMethod="Get"
    UpdateMethod="Save"
    OnUpdating="srcBlogComments_Updating"
    OnUpdated="srcBlogComments_Updated" 
    OnSelected="srcBlogComments_Selected"
    Runat="server" >
    <SelectParameters>
        <asp:QueryStringParameter Name="Id" QueryStringField="Id" />
    </SelectParameters>
</super:EntityDataSource>    
    
    
    


</asp:Content>

