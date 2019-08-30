<%@ Page Language="vb" MasterPageFile="~/Design/MasterPage.master" ValidateRequest="false" %>

<script runat="server">

 
    Private  Sub Page_Load()
        If String.IsNullOrEmpty(Request("entryId")) Then
            Response.Redirect("~/Authenticated/Entries/Add.aspx")
        End If
    End Sub
 
 
    Protected  Sub srcCodeSample_Updating(ByVal sender As Object, ByVal e As ObjectDataSourceMethodEventArgs)
        Dim sample As CodeSample = CType(e.InputParameters(1), CodeSample)
        If sample.Id = 0 Then
            sample.EntryId = Int32.Parse(Request("entryId"))
        End If
    End Sub
 
 
    Protected  Sub srcCodeSample_Updated(ByVal sender As Object, ByVal e As ObjectDataSourceStatusEventArgs)
        If e.Exception Is Nothing Then
            Dim sample As CodeSample = CType(e.ReturnValue, CodeSample)
            Response.Redirect("~/Authenticated/CodeSamples/Default.aspx?entryId=" & sample.EntryId.ToString())
        End If
    End Sub
 
 
    Protected  Sub frmCodeSample_ItemUpdated(ByVal sender As Object, ByVal e As FormViewUpdatedEventArgs)
        If Not e.Exception Is Nothing Then
            e.KeepInEditMode = True
            e.ExceptionHandled = True
            ValidationUtility.ShowValidationErrors(Me, e.Exception)
        End If
    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" runat="server">
    
    
<asp:UpdatePanel ID="up1" runat="server">
<ContentTemplate>    
<asp:FormView 
    ID="frmCodeSample" 
    DataSourceID="srcCodeSample"  
    DefaultMode="Edit"
    DataKeyNames="Id,EntryId,Version"
    OnItemUpdated="frmCodeSample_ItemUpdated"
    runat="server">
    <EditItemTemplate>

       
    <super:EntityValidator
        id="valAuthorUserName"
        PropertyName="AuthorUserName"
        CssClass="errorMessage"
        Runat="server" />


    <div class="field">
        <div class="fieldLabel">
        <asp:Label 
            ID="lblFileName" 
            Text="File Name:" 
            AssociatedControlID="txtFileName" 
            runat="server" />        
        </div>
        <div class="fieldValue">
        <asp:TextBox
            id="txtFileName"
            Text='<%# Bind("FileName") %>'
            Columns="60"
            runat="server" />
        </div>
        <div class="fieldValue">
        <super:EntityCallOutValidator 
            ID="valFileName" 
            PropertyName="FileName"
            Runat="Server" />
        </div>    
    </div>        


    <div class="field">
        <div class="fieldLabel">
        <asp:Label 
            ID="lblLanguage" 
            Text="File Language:" 
            AssociatedControlID="ddlLanguage" 
            runat="server" />        
        </div>
        <div class="fieldValue">
        <asp:DropDownList
            id="ddlLanguage"
            SelectedValue='<%# Bind("LanguageId") %>'
            DataSourceID="srcLanguages"
            DataTextField="Name"
            DataValueField="Id"
            AppendDataBoundItems="true"
            runat="server">
            <asp:ListItem Text="Select Language" Value="-1" />
        </asp:DropDownList>    
        <super:EntityDataSource
            id="srcLanguages"
            TypeName="CodeSampleLanguage"
            SelectMethod="SelectCached"
            Runat="Server" />    
        </div>  
        <div class="fieldValue">
        <super:EntityCallOutValidator 
            ID="EntityCallOutValidator2" 
            PropertyName="LanguageId"
            Runat="Server" />
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
        <asp:Label 
            ID="lblCode" 
            Text="Code:" 
            AssociatedControlID="txtCode" 
            runat="server" />        
        </div>
        <div class="fieldValue">
        <asp:TextBox
            id="txtCode"
            Text='<%# Bind("Code") %>'
            TextMode="MultiLine"
            Columns="80"
            Rows="10"
            Wrap="false"
            runat="server" />
        </div>
        <div class="fieldValue">
        <super:EntityCalloutValidator 
            ID="valCode" 
            PropertyName="Code"
            Runat="Server" />
        </div>
    </div>


    <asp:Panel
        id="pnlAdministrators"
        Visible='<%# User.IsInRole("Administrators") %>'
        Runat="server">

    
        <div class="field">
            <div class="fieldLabel">
            <asp:Label
                id="lblEnableTryIt"
                AssociatedControlID="chkEnableTryIt"
                Text="Enable Try It:"
                Runat="server" />
            </div>
            <div class="fieldValue">
            <asp:CheckBox
                id="chkEnableTryIt"
                Checked='<%# Bind("EnableTryIt") %>'
                Runat="server" />
            </div>    
        </div>
    
    
        <div class="field">
            <div class="fieldLabel">
            <asp:Label 
                ID="lblTryItCode" 
                Text="Try It Code:" 
                AssociatedControlID="txtTryItCode" 
                runat="server" />        
            </div>
            <div class="fieldValue">
            <asp:TextBox
                id="txtTryItCode"
                Text='<%# Bind("TryItCode") %>'
                TextMode="MultiLine"
                Columns="80"
                Rows="10"
                Wrap="false"
                runat="server" />
            </div>
            <div class="fieldValue">
            <super:EntityCalloutValidator 
                ID="EntityCalloutValidator1" 
                PropertyName="TryItCode"
                Runat="Server" />
            </div>
        </div>
    </asp:Panel>



    <div class="field">
        <div class="fieldLabel">
        </div>
        <div class="fieldValue">
        <asp:Button
            id="btnSave"
            Text="Save"
            CommandName="Update"
            Runat="server" />
        </div>
    </div>


    </EditItemTemplate>
</asp:FormView>
</ContentTemplate>
</asp:UpdatePanel>



<super:EntityDataSource 
    id="srcCodeSample"
    TypeName="CodeSample"
    DataObjectTypeName="CodeSample"
    SelectMethod="Get"
    UpdateMethod="Save"
    Runat="server" OnUpdating="srcCodeSample_Updating" OnUpdated="srcCodeSample_Updated">
    <SelectParameters>
        <asp:QueryStringParameter Name="id" QueryStringField="sampleId" ConvertEmptyStringToNull="true" />
    </SelectParameters>
 </super:EntityDataSource>   

    

    
    
    </div>
    
</asp:Content>
