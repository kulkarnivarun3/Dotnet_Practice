<%@ Page Language="vb" MasterPageFile="~/Design/MasterPage.master" Title="Edit Comment" %>

<script runat="server">
 
    Protected Sub srcBlogComments_Selected(ByVal sender As Object, ByVal e As ObjectDataSourceStatusEventArgs)
        ' If new blog comment entry, get title from Blog
        Dim NewBlogComment As BlogComment = CType(e.ReturnValue, BlogComment)
        If NewBlogComment.Id = 0 Then
            Dim blog As Blog = Blog.Get(Int32.Parse(Request("blogId")))
            NewBlogComment.Title = "RE: " & blog.Title
        End If
    End Sub
 
    Protected Sub srcBlogComments_Updating(ByVal sender As Object, ByVal e As ObjectDataSourceMethodEventArgs)
        ' If new blog comment, add user name and blog id
        Dim NewBlogComment As BlogComment = CType(e.InputParameters(1), BlogComment)
        If NewBlogComment.Id = 0 Then
            NewBlogComment.AuthorUserName = User.Identity.Name
            NewBlogComment.BlogId = Int32.Parse(Request("blogId"))
        End If
    End Sub
 
    Protected Sub srcBlogComments_Updated(ByVal sender As Object, ByVal e As ObjectDataSourceStatusEventArgs)
        Dim NewBlogComment As BlogComment = CType(e.ReturnValue, BlogComment)
        If Not IsNothing(NewBlogComment) And NewBlogComment.IsValid Then
            Response.Redirect("~/Blog/Default.aspx?blogId=" & NewBlogComment.BlogId)
        End If
    End Sub
 
 
    Protected Sub frmBlogComment_ItemUpdated(ByVal sender As Object, ByVal e As FormViewUpdatedEventArgs)
        If Not e.Exception Is Nothing Then
            e.KeepInEditMode = True
            e.ExceptionHandled = True
 
            ValidationUtility.ShowValidationErrors(me, e.Exception)
        End If
    End Sub


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

