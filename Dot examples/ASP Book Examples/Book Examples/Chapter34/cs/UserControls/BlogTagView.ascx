<%@ Control Language="C#" ClassName="BlogTagView" %>

<script runat="server">

    public int BlogId { get; set; }

    protected void srcBlogTags_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["blogId"] = BlogId;
    }

</script>

<asp:ListView
    id="lstTags"
    DataSourceId="srcBlogTags"
    Runat="server">
    <LayoutTemplate>
        <div class="blogTags">
            Tags: <span><asp:PlaceHolder id="itemPlaceholder" runat="server" /></span>
        </div>
    </LayoutTemplate>
    <ItemTemplate>
        <asp:HyperLink
            id="lnk"
            Text='<%# Eval("Name") %>'
            NavigateUrl='<%# Eval("Name", "~/Blog/BlogsByTag.aspx?tagName={0}") %>'
            Runat="server" />
    </ItemTemplate>    
</asp:ListView>

<asp:ObjectDataSource
    id="srcBlogTags"
    TypeName="BlogTag"
    SelectMethod="SelectByBlogId"
    Runat="server" OnSelecting="srcBlogTags_Selecting" />