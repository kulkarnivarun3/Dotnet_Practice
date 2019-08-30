<%@ Control Language="vb" ClassName="BlogTagView" %>

<script runat="server">
 
    Private _BlogId As Integer
    Public Property BlogId() As Integer
        Get
            Return _BlogId
        End Get
        Set(ByVal value As Integer)
            _BlogId = value
        End Set
    End Property

 
    Protected  Sub srcBlogTags_Selecting(ByVal sender As Object, ByVal e As ObjectDataSourceSelectingEventArgs)
        e.InputParameters("blogId") = BlogId
    End Sub

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