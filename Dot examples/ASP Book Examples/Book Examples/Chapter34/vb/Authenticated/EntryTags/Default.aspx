<%@ Page Language="vb" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>

<script runat="server">

   
    Public Property EnTryId() As Integer
    	Get 
        	 Return CType(ViewState("EntryId"), Integer)
    	End Get
    	Set (ByVal Value As Integer) 
        	 ViewState("EntryId") = value
    	End Set
    End Property
 
    Private  Sub Page_Load()
        If Not IsPostBack Then
            If String.IsNullOrEmpty(Request("entryId")) Then
                Response.Redirect("~/Authenticated/Entries/Add.aspx")
            End If
            EnTryId = Int32.Parse(Request("EntryId"))
        End If
    End Sub
 
 
    Protected  Sub btnPrevious_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("~/Authenticated/CodeSamples/Default.aspx?entryId=" & EnTryId.ToString())
    End Sub
 
    Protected  Sub srcTags_Inserting(ByVal sender As Object, ByVal e As ObjectDataSourceMethodEventArgs)
        Dim tag As EnTryTag = CType(e.InputParameters(0), EnTryTag)
        tag.EnTryId = EnTryId
    End Sub
 
 
    Protected  Sub frmInsert_ItemInserted(ByVal sender As Object, ByVal e As FormViewInsertedEventArgs)
        If Not e.Exception Is Nothing Then
            e.ExceptionHandled = True
            e.KeepInInsertMode = True
            ValidationUtility.ShowValidationErrors(Me, e.Exception)
        End If
    End Sub
 
    Protected  Sub btnFinish_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("~/CodeSamples/Entry.aspx?entryId=" & EnTryId.ToString())
    End Sub
 
 
    <System.Web.Services.WebMethod()> _
    <System.Web.Script.Services.ScriptMethod()> _
    Public Shared Function GetSuggestions(ByVal prefixText As String, ByVal count As Integer) As String()
        Return EntryTag.GetSuggestions(prefixText, count)
    End Function
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">


    <asp:FormView 
        ID="frmInsert"
        DataSourceID="srcTags"
        DefaultMode="Insert"
        runat="server" OnItemInserted="frmInsert_ItemInserted">
        <InsertItemTemplate>
        
        
        <super:EntityValidator
            id="valAuthorUserName"
            PropertyName="AuthorUserName"
            CssClass="errorMessage"
            Runat="server" />
        
        <asp:Label
            id="lblTag"
            Text="Tag:"
            AssociatedControlID="txtTag"
            Runat="server" />
        <asp:TextBox
            id="txtTag"
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
        DataKeyNames="Id,EntryId,Version"
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
        TypeName="EntryTag"
        SelectMethod="SelectByEntryId"
        OnInserting="srcTags_Inserting"
        Runat="server" >
        <SelectParameters>
            <asp:QueryStringParameter Name="entryId" QueryStringField="entryId" />
        </SelectParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="entryId" QueryStringField="entryId" />
        </InsertParameters>
    </super:EntityDataSource>


<div class="divWizardButtons">
    <asp:Button
        id="btnPrevious"
        Text="Previous"
        Runat="server" OnClick="btnPrevious_Click" />
    
    <asp:Button
        id="btnFinish"
        Text="Finish"
        Runat="server" OnClick="btnFinish_Click" />

</div>

</asp:Content>


