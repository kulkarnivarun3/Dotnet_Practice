<%@ Page Language="C#" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>

<script runat="server">


    protected void srcChapter_Updating(object sender, ObjectDataSourceMethodEventArgs e)
    {
        Chapter newChapter = (Chapter)e.InputParameters[1];
        if (newChapter.Id == 0)
        {
            newChapter.BookId = Int32.Parse(Request["bookId"]);
        }
    }


    protected void srcChapter_Updated(object sender, ObjectDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            Chapter newChapter = (Chapter)e.ReturnValue;
            Response.Redirect("~/Admin/Chapters/Default.aspx?bookId=" + newChapter.BookId.ToString());
        }
    }

    protected void frmChapter_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
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

