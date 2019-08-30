<%@ Page Language="vb" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>

<script runat="server">
 
 
    Protected  Sub srcChapter_Updating(ByVal sender As Object, ByVal e As ObjectDataSourceMethodEventArgs)
        Dim NewChapter As Chapter = CType(e.InputParameters(1), Chapter)
        If NewChapter.Id = 0 Then
            NewChapter.BookId = Int32.Parse(Request("bookId"))
        End If
    End Sub
 
 
    Protected  Sub srcChapter_Updated(ByVal sender As Object, ByVal e As ObjectDataSourceStatusEventArgs)
        If e.Exception Is Nothing Then
            Dim NewChapter As Chapter = CType(e.ReturnValue, Chapter)
            Response.Redirect("~/Admin/Chapters/Default.aspx?bookId=" & NewChapter.BookId.ToString())
        End If
    End Sub
 
    Protected  Sub frmChapter_ItemUpdated(ByVal sender As Object, ByVal e As FormViewUpdatedEventArgs)
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
    id="frmChapter"
    DataSourceID="srcChapter"
    DataKeyNames="Id,BookId,Version"
    DefaultMode="Edit"
    OnItemUpdated="frmChapter_ItemUpdated"
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
            id="lblDescription"
            Text="Description:"
            AssociatedControlID="txtDescription"
            Runat="server" />
        </div>
        <div class="fieldValue">
        <fck:FCKeditor
            id="txtDescription" 
            BasePath="~/FCKEditor/"
            ToolbarSet="Superexpert"
            Value='<%# Bind("Description") %>'
            Width="600px"
            Height="300px"
            runat="server" />        
        </div>
        <div class="fieldValue">
        <super:EntityCallOutValidator
            id="valDescription"
            PropertyName="Description"
            Runat="server" />
        </div>
    </div>


    <div class="field">
        <div class="fieldLabel">
        </div>
        <div class="fieldValue">
        <asp:Button
            id="btnUpdate"
            CommandName="Update"
            Text="Save"
            Runat="server" />
        </div>
    </div>

</EditItemTemplate>
</asp:FormView>    
</ContentTemplate>
</asp:UpdatePanel>

<super:EntityDataSource
    id="srcChapter"
    TypeName="Chapter"
    SelectMethod="Get"
    UpdateMethod="Save"
    OnUpdated="srcChapter_Updated"
    Runat="server" OnUpdating="srcChapter_Updating">
    <SelectParameters>
        <asp:QueryStringParameter Name="id" QueryStringField="chapterId" />
    </SelectParameters>
</super:EntityDataSource>    



</asp:Content>

