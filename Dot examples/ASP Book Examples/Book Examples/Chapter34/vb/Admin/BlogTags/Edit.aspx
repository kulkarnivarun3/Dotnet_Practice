<%@ Page Language="vb" MasterPageFile="~/Design/MasterPage.master" Title="Edit Blog Tags" %>

<script runat="server">
 
    Private  Sub Page_Load()
        If Not IsPostBack Then
            If String.IsNullOrEmpty(Request("blogId")) Then
                Response.Redirect("~/Admin/Blog/Edit.aspx")
            End If
        End If
    End Sub
 
 
    Protected  Sub btnPrevious_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("~/Admin/Blog/Edit.aspx?blogId=" & Request("blogId"))
    End Sub
 
    Protected  Sub btnFinish_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("~/Blog/Default.aspx?blogId=" & Request("blogId"))
    End Sub
 
    Protected  Sub srcTags_Inserting(ByVal sender As Object, ByVal e As ObjectDataSourceMethodEventArgs)
        Dim NewTag As BlogTag = CType(e.InputParameters(0), BlogTag)
        NewTag.BlogId = Int32.Parse(Request("blogId"))
    End Sub
 
    Protected  Sub srcTags_Inserted(ByVal sender As Object, ByVal e As ObjectDataSourceStatusEventArgs)
        If Not e.Exception Is Nothing Then
            ValidationUtility.ShowValidationErrors(Me, e.Exception)
        End If
    End Sub
 
    Protected  Sub frmInsert_ItemInserted(ByVal sender As Object, ByVal e As FormViewInsertedEventArgs)
        If Not e.Exception Is Nothing Then
            e.ExceptionHandled = True
            e.KeepInInsertMode = True
        End If
    End Sub
 
    <System.Web.Services.WebMethod()> _
    <System.Web.Script.Services.ScriptMethod()> _
    Public Shared Function GetSuggestions(ByVal prefixText As String, ByVal count As Integer) As String()
        Return BlogTag.GetSuggestions(prefixText, count)
    End Function

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">


    <asp:FormView 
        ID="frmInsert"
        DataSourceID="srcTags"
        DefaultMode="Insert"
        runat="server" OnItemInserted="frmInsert_ItemInserted">
    <InsertItemTemplate>
    <asp:Label
        id="lblTag"
        Text="Tag:"
        AssociatedControlID="txtTag"
        Runat="server" />
    <asp:TextBox
        id="txtTag"
        AutoComplete="Off"
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
        DataKeyNames="Id,Version"
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
        TypeName="BlogTag"
        SelectMethod="SelectByBlogId"
        Runat="server" OnInserting="srcTags_Inserting" OnInserted="srcTags_Inserted">
        <SelectParameters>
            <asp:QueryStringParameter Name="BlogId" QueryStringField="blogId" />
        </SelectParameters>
    </super:EntityDataSource>


<div class="divWizardButtons">
 
    <asp:Button
        id="btnPrevious"
        Text="Previous"
        OnClick="btnPrevious_Click" 
        Runat="server" />
    
    <asp:Button
        id="btnFinish"
        Text="Finish"
        OnClick="btnFinish_Click" 
        Runat="server" />

</div>

</asp:Content>


