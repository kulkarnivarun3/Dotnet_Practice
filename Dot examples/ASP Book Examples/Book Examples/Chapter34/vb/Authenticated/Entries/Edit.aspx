<%@ Page Language="vb" MasterPageFile="~/Design/MasterPage.master" ValidateRequest="false" %>

<script runat="server">

 
    Protected Sub srcEntry_Updating(ByVal sender As Object, ByVal e As ObjectDataSourceMethodEventArgs)
        Dim NewEntry As Entry = CType(e.InputParameters(1), Entry)
        If NewEntry.Id = 0 Then
            NewEntry.AuthorUserName = User.Identity.Name
            NewEntry.ViewCount = 0
        End If
    End Sub
 
 
    Protected Sub srcEntry_Updated(ByVal sender As Object, ByVal e As ObjectDataSourceStatusEventArgs)
        If e.Exception Is Nothing Then
            Dim NewEntry As Entry = CType(e.ReturnValue, Entry)
            Response.Redirect("~/Authenticated/CodeSamples/Default.aspx?entryId=" & NewEntry.Id)
        End If
    End Sub
 
 
    Protected Sub frmEntry_ItemUpdated(ByVal sender As Object, ByVal e As FormViewUpdatedEventArgs)
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
        ID="frmEntry" 
        DataSourceID="srcEntry"  
        DefaultMode="Edit"
        DataKeyNames="Id,Version"
        OnItemUpdated="frmEntry_ItemUpdated"
        runat="server">
        <EditItemTemplate>

        <div class="field">
            <div class="fieldLabel">
            <asp:Label 
                ID="lblTitle" 
                Text="Title:" 
                AssociatedControlID="txtTitle" 
                runat="server" />
            </div>
            <div class="fieldValue">
            <asp:TextBox
                id="txtTitle"
                Text='<%# Bind("Title") %>'
                Columns="60"
                runat="server" />
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
                ID="lblIntroductionText" 
                Text="Introduction Text:" 
                AssociatedControlID="txtIntroductionText" 
                runat="server" />
            </div>
            <div class="fieldValue">
            <asp:TextBox
                id="txtIntroductionText"
                Text='<%# Bind("IntroductionText") %>'
                TextMode="MultiLine"
                Columns="60"
                Rows="3"
                runat="server" />
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
                ID="lblDescription" 
                Text="Description:" 
                AssociatedControlID="txtDescription" 
                runat="server" />
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
            <super:EntityCalloutValidator 
                ID="EntityValidator1" 
                PropertyName="Description"
                Runat="Server" />
            </div>
        </div>        

        <div class="field">
            <div class="fieldLabel">
            </div>
            <div>
            <asp:Button
                id="btnSave"
                Text="Next"
                CommandName="Update" 
                Runat="server" />
            </div>
        </div>


        </EditItemTemplate>
    </asp:FormView>

    </ContentTemplate>
    </asp:UpdatePanel>


    <super:EntityDataSource 
        id="srcEntry"
        TypeName="Entry"
        SelectMethod="Get"
        UpdateMethod="Save"
        Runat="server" OnUpdating="srcEntry_Updating" OnUpdated="srcEntry_Updated">
        <SelectParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="entryId" ConvertEmptyStringToNull="true" />
        </SelectParameters>
     </super:EntityDataSource>   

 
</asp:Content>



