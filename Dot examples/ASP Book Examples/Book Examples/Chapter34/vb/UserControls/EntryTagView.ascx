<%@ Control Language="vb" ClassName="EntryTagView" %>

<script runat="server">
 
    Private _EntryId As Integer
    Public Property EntryId() As Integer
        Get
            Return _EntryId
        End Get
        Set(ByVal value As Integer)
            _EntryId = value
        End Set
    End Property

 
 
    Protected Sub srcEnTryTags_Selecting(ByVal sender As Object, ByVal e As ObjectDataSourceSelectingEventArgs)
        e.InputParameters("entryId") = EnTryId
    End Sub

</script>



<asp:ListView
    id="lstTags"
    DataSourceId="srcEntryTags"
    Runat="server">
    <LayoutTemplate>
        <div class="entryTags">
        Tags: <span><asp:PlaceHolder id="itemPlaceholder" runat="server" /></span>
        </div>
    </LayoutTemplate>
    <ItemTemplate>
        <asp:HyperLink
            id="lnk"
            Text='<%# Eval("Name") %>'
            NavigateUrl='<%# Eval("Name", "~/CodeSamples/EntriesByTag.aspx?tag={0}") %>'
            Runat="server" />
    </ItemTemplate>    
</asp:ListView>


<asp:ObjectDataSource
    id="srcEntryTags"
    TypeName="EntryTag"
    SelectMethod="SelectByEntryId"
    OnSelecting="srcEntryTags_Selecting" 
    Runat="server" />