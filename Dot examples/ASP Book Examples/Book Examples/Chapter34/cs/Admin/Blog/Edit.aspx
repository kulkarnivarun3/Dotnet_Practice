<%@ Page Language="C#" MasterPageFile="~/Design/MasterPage.master" Title="Blog Post" %>
<script runat="server">


    /// <summary>
    /// Add default values for new blog entry
    /// </summary>
    protected void srcBlog_Updating(object sender, ObjectDataSourceMethodEventArgs e)
    {
        // If new blog entry, add user name
        Blog newBlog = (Blog)e.InputParameters[1];
        if (newBlog.Id == 0)
        {
            newBlog.AuthorUserName = User.Identity.Name;
        }
    }

    /// <summary>
    /// If no problems, then redirect to blog tags page
    /// </summary>
    protected void srcBlog_Updated(object sender, ObjectDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            Blog newBlog = (Blog)e.ReturnValue;
            Response.Redirect("~/Admin/BlogTags/Edit.aspx?blogId=" + newBlog.Id);
        }
    }


    /// <summary>
    /// If there was a problem, keep the form in edit mode and show validation errors
    /// </summary>
    protected void frmBlog_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
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
    id="frmBlog"
    DataSourceID="srcBlog"
    DataKeyNames="Id,Version"
    DefaultMode="Edit"
    OnItemUpdated="frmBlog_ItemUpdated"
    Width="100%"
    Runat="server">
    <EditItemTemplate>
    
    <div class="field">
        <div class="fieldLabel">
        <asp:Label
            id="lblTitle"
            Text="Title:"
            AssociatedControlID="txtTitle"
            Runat="server" />
        </div>
        <div class="fieldValue">
        <asp:TextBox
            id="txtTitle"
            Text='<%# Bind("Title") %>'
            Columns="60"
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
            id="lblIntroductionText"
            Text="Introduction Text:"
            AssociatedControlID="txtIntroductionText"
            Runat="server" />
        </div>
        <div class="fieldValue">
        <asp:TextBox
            id="txtIntroductionText"
            Text='<%# Bind("IntroductionText") %>'
            TextMode="MultiLine"
            Columns="60"
            Rows="4"
            Runat="server" />       
        </div>
        <div class="fieldValue">
        <super:EntityCallOutValidator
            id="valIntroductionText"
            PropertyName="IntroductionText"
            Runat="server" />                 
        </div>        
    </div>

    <div class="field">
        <div class="fieldLabel">
        <asp:Label
            id="lblPost"
            Text="Post:"
            AssociatedControlID="txtPost"
            Runat="server" />
        </div>
        <div class="fieldValue">
        <fck:FCKeditor
            id="txtPost" 
            BasePath="~/FCKEditor/"
            ToolbarSet="Superexpert"
            Value='<%# Bind("Post") %>'
            Width="600px"
            Height="600px"
            runat="server" />        
        </div>
        <div class="fieldValue">
        <super:EntityCallOutValidator
            id="EntityCallOutValidator1"
            PropertyName="Post"
            Runat="server" />                             
        </div>
    </div>
    
    <div class="field">
        <div class="fieldLabel">
        </div>
        <div>
        <asp:CheckBox
            id="chkIsPinned"
            Text="Is Pinned"
            Checked='<%# Bind("IsPinned") %>'
            Runat="server" />
        </div>
    </div>
    
    <div class="field">
        <div class="fieldLabel">
        </div>
        <div>
        <asp:Button
            id="btnNext"
            CommandName="Update"
            Text="Next"
            Runat="server" />
        </div>
    </div>
    
    </EditItemTemplate>    
</asp:FormView>
</ContentTemplate>
</asp:UpdatePanel>

<super:EntityDataSource
    id="srcBlog"
    TypeName="Blog"
    SelectMethod="Get"
    UpdateMethod="Save"
    OnUpdating="srcBlog_Updating"
    OnUpdated="srcBlog_Updated"
    Runat="Server">
    <SelectParameters>
        <asp:QueryStringParameter Name="id" QueryStringField="blogId" />
    </SelectParameters> 
</super:EntityDataSource>    


</asp:Content>

