<%@ Page Language="vb" MasterPageFile="~/Design/MasterPage.master" Title="Blog Post" %>
<script runat="server">
 
 
    ''' <summary>
    ''' Add default values for new blog entry
    ''' </summary>
    Protected Sub srcBlog_Updating(ByVal sender As Object, ByVal e As ObjectDataSourceMethodEventArgs)
        ' If new blog entry, add user name
        Dim NewBlog As Blog = CType(e.InputParameters(1), Blog)
        If NewBlog.Id = 0 Then
            NewBlog.AuthorUserName = User.Identity.Name
        End If
    End Sub
 
    ''' <summary>
    ''' If no problems, then redirect to blog tags page
    ''' </summary>
    Protected Sub srcBlog_Updated(ByVal sender As Object, ByVal e As ObjectDataSourceStatusEventArgs)
        If e.Exception Is Nothing Then
            Dim NewBlog As Blog = CType(e.ReturnValue, Blog)
            Response.Redirect("~/Admin/BlogTags/Edit.aspx?blogId=" & NewBlog.Id)
        End If
    End Sub
 
 
    ''' <summary>
    ''' If there was a problem, keep the form in edit mode and show validation errors
    ''' </summary>
    Protected Sub frmBlog_ItemUpdated(ByVal sender As Object, ByVal e As FormViewUpdatedEventArgs)
        If Not e.Exception Is Nothing Then
            e.KeepInEditMode = True
            e.ExceptionHandled = True
            ValidationUtility.ShowValidationErrors(Me, e.Exception)
        End If
    End Sub

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

