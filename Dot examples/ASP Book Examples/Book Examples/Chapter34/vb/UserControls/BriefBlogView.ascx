<%@ Control Language="vb" ClassName="BriefBlogView" %>
<%@ Register TagPrefix="user" TagName="UserView" Src="~/UserControls/UserView.ascx" %>
<%@ Register TagPrefix="user" TagName="BlogTagView" Src="~/UserControls/BlogTagView.ascx" %>

<script runat="server">

    private _BlogId As Integer
    
    public Property BlogId As Integer
    get
        return _BlogId
    end get
    set
        _BlogId = value
    end set
    end property
    

</script>

<div class="blogRow">

    <%--<%# Eval("Id") %>--%>
    <asp:HyperLink
        id="lnkBlog"
        NavigateUrl='<%# Eval("Id", "~/Blog/Default.aspx?blogId={0}") %>'
        runat="server">
        <h3>    
        <asp:Literal
            id="ltlTitle"
            Text='<%# Eval("Title") %>'
            Mode="Encode"
            Runat="server" />
        </h3>
    </asp:HyperLink>

    <p>
        <asp:Literal
            id="ltlIntroductionText"
            Text='<%# Eval("IntroductionText") %>'
            Mode="Encode"
            Runat="server" />
    </p>

    <div class="metaInfo">
        Posted: <user:UserView ID="UserView1" runat="server" /> on <%# Eval("DateCreated", "{0:D}") %> | <%# Eval("CommentCount") %> Comments

        <user:BlogTagView
            id="BlogTagView1"
            BlogId='<%# Eval("Id") %>'
            Runat="server" />   
    </div> 
    
</div>