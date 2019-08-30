<%@ Page Language="vb" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>

<script runat="server">
 
 
    <System.Web.Services.WebMethod()> _
    <System.Web.Script.Services.ScriptMethod()> _
    Public Shared Function GetSuggestions(ByVal prefixText As String, ByVal count As Integer) As String()
        Return Entry.GetSuggestions(prefixText, count)
    End Function
 
 
 
    Protected Sub btnFilter_Click(ByVal sender As Object, ByVal e As EventArgs)
        If Not String.IsNullOrEmpty(txtEnTryTitle.Text) Then
            grdMatch.DataSource = Entry.SelectByTitle(txtEntryTitle.Text)
            grdMatch.DataBind()
        End If
    End Sub
 
    Protected Sub grdMatch_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim enTryId As Integer = CType(grdMatch.SelectedValue, Integer)
        Dim chapterId As Integer = Int32.Parse(Request("chapterId"))
        Listing.Insert(New Listing() With {.EntryId = enTryId, .ChapterId = chapterId, .OrderNumber = 0})
        Response.Redirect("~/Books/Listings.aspx?chapterId=" & chapterId.ToString())
    End Sub


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">


 <h3>Add Listing</h3>


    <asp:Label
        id="lblEntryTitle"
        Text="Filter by Entry Title"
        AssociatedControlID="txtEntryTitle"
        Runat="server" /> 
    <asp:TextBox
        id="txtEntryTitle"
        AutoComplete="Off"
        Text='<%# Bind("Name") %>'
        Runat="server" />
    <ajaxToolkit:AutoCompleteExtender 
        ID="AutoCompleteExtender1"
        ServiceMethod="GetSuggestions"
        TargetControlID="txtEntryTitle"
        MinimumPrefixLength="1"
        Runat="server" />
    <asp:Button
        id="btnFilter"
        Text="Filter"
        Runat="server" OnClick="btnFilter_Click" />



    <br />
    
    <asp:GridView
        id="grdMatch"
        DataKeyNames="Id"
        AutoGenerateSelectButton="true"
        AutoGenerateColumns="false"
        Runat="server" OnSelectedIndexChanged="grdMatch_SelectedIndexChanged">
        <Columns>
            <asp:BoundField DataField="Title" HeaderText="Title" />
        </Columns>    
        <EmptyDataTemplate>
        No matching code samples
        </EmptyDataTemplate>
    </asp:GridView>    
 
 



</asp:Content>

