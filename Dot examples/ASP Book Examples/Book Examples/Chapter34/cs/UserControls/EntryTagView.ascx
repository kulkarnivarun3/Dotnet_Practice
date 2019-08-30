<%@ Control Language="C#" ClassName="EntryTagView" %>

<script runat="server">

    public int EntryId { get; set; }


    protected void srcEntryTags_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["entryId"] = EntryId;
    }

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