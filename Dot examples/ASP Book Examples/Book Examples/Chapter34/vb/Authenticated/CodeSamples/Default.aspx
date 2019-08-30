<%@ Page Language="vb" MasterPageFile="~/Design/MasterPage.master" %>

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
            lnkAdd.NavigateUrl = "Edit.aspx?entryId=" & EnTryId.ToString()
        End If
    End Sub
 
 
 
    Protected  Sub btnNext_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("~/Authenticated/EntryTags/Default.aspx?entryId=" & EnTryId.ToString())
    End Sub
 
    Protected  Sub btnPrevious_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("~/Authenticated/Entries/Edit.aspx?entryId=" & EnTryId.ToString())
    End Sub
 
    Protected  Sub grdCodeSamples_DataBound(ByVal sender As Object, ByVal e As EventArgs)
        btnNext.Enabled = (grdCodeSamples.Rows.Count > 0)
    End Sub

</script>


<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" runat="server">
    <asp:Panel DefaultButton="btnNext" runat="server">  
    <asp:GridView
        id="grdCodeSamples"
        DataKeyNames="Id,Version"
        DataSourceID="srcCodeSamples"
        AutoGenerateColumns="False"
        Runat="server" OnDataBound="grdCodeSamples_DataBound">
        <EmptyDataTemplate>
            You have not added any code samples. To add a new code sample,
            click Add Code Sample.
        </EmptyDataTemplate>
        <Columns>
        <asp:TemplateField>
        <ItemTemplate>
            <asp:LinkButton
                id="lnkDelete"
                Text="Delete"
                CommandName="Delete"
                OnClientClick="return confirm('Delete code sample?');"
                Runat="server" />
        </ItemTemplate>
        </asp:TemplateField>
        <asp:HyperLinkField DataNavigateUrlFields="EntryId,Id" DataNavigateUrlFormatString="Edit.aspx?entryId={0}&sampleId={1}" Text="Edit" />
        <asp:BoundField DataField="FileName" />
        </Columns>    
    </asp:GridView>
    
    <super:EntityDataSource
        id="srcCodeSamples"
        TypeName="CodeSample"
        SelectMethod="SelectByEntryId"
        Runat="server">
        <SelectParameters>
            <asp:QueryStringParameter Name="entryId" QueryStringField="entryId" />
        </SelectParameters>
    </super:EntityDataSource>    
    
    <br />
    
    <asp:HyperLink
        id="lnkAdd"
        Text="Add Code Sample"
        Runat="server" />
    
    <div>
        <br />
        <asp:Button
            id="btnPrevious"
            Text="Previous"
            Runat="server" OnClick="btnPrevious_Click" />

        <asp:Button
            id="btnNext"
            Text="Next"
            OnClick="btnNext_Click" 
            Runat="server" />
    </div>
</asp:Panel>    
    
</asp:Content>