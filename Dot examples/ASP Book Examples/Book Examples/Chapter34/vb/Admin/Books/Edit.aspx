<%@ Page Language="vb" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>

<script runat="server">
 
    Protected  Sub frmBook_ItemUpdated(ByVal sender As Object, ByVal e As FormViewUpdatedEventArgs)
        If Not e.Exception Is Nothing Then
            e.KeepInEditMode = True
            e.ExceptionHandled = True
            ValidationUtility.ShowValidationErrors(me, e.Exception)
        End If
    End Sub
 
    Protected  Sub srcBook_Updated(ByVal sender As Object, ByVal e As ObjectDataSourceStatusEventArgs)
        If e.Exception Is Nothing Then
            Dim NewBook As Book = CType(e.ReturnValue, Book)
            Response.Redirect("~/Admin/Chapters/Default.aspx?bookId=" & NewBook.Id.ToString())
        End If
    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

<asp:UpdatePanel id="up1" runat="server">
<ContentTemplate>
<asp:FormView
    id="frmBook"
    DataSourceID="srcBook"
    DataKeyNames="Id,Version"
    DefaultMode="Edit"
    Runat="server" OnItemUpdated="frmBook_ItemUpdated">
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
            id="lblAuthors"
            Text="Author(s):"
            AssociatedControlID="txtAuthors"
            Runat="server" />
        </div>
        <div class="fieldValue">
        <asp:TextBox
            id="txtAuthors"
            Text='<%# Bind("Authors") %>'
            Runat="server" />    
        </div>
        <div class="fieldValue">
        <super:EntityCallOutValidator
            id="valAuthors"
            PropertyName="Authors"
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
            Height="600px"
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
        <asp:Label
            id="lblBuyLink"
            Text="Buy link:"
            AssociatedControlID="txtBuyLink"
            Runat="server" />
        </div>
        <div class="fieldValue">
        <asp:TextBox
            id="txtBuyLink"
            Text='<%# Bind("BuyLink") %>'
            Columns="60"
            Runat="server" />    
        </div>
        <div class="fieldValue">
        <super:EntityCallOutValidator
            id="valBuyLink"
            PropertyName="BuyLink"
            Runat="server" />
        </div>
    </div>



    <div class="field">
        <div class="fieldLabel">
        <asp:Label
            id="lblCoverPicture"
            Text="Cover Picture:"
            Columns="60"
            AssociatedControlID="txtCoverPicture"
            Runat="server" />
        </div>
        <div class="fieldValue">
        <asp:TextBox
            id="txtCoverPicture"
            Text='<%# Bind("CoverPicture") %>'
            Columns="60"
            Runat="server" />    
        </div>
        <div class="fieldValue">
        <super:EntityCallOutValidator
            id="valCoverPicture"
            PropertyName="CoverPicture"
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
            Text="Next"
            Runat="server" />
        </div>
    </div>

</EditItemTemplate>
</asp:FormView>    
</ContentTemplate>
</asp:UpdatePanel>

<super:EntityDataSource
    id="srcBook"
    TypeName="Book"
    SelectMethod="Get"
    UpdateMethod="Save"
    Runat="server" OnUpdated="srcBook_Updated">
    <SelectParameters>
        <asp:QueryStringParameter Name="id" QueryStringField="bookId" />
    </SelectParameters>
</super:EntityDataSource>    

</asp:Content>

