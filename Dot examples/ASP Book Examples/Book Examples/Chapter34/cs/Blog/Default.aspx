<%@ Page Language="C#" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>
<%@ Register TagPrefix="user" TagName="BlogTagView" Src="~/UserControls/BlogTagView.ascx" %>

<script runat="server">

    public string BlogAuthorUserName
    {
        get { return (string)ViewState["BlogAuthorUserName"]; }
        set { ViewState["BlogAuthorUserName"] = value; }
    }

    void Page_Load()
    {
        if (!IsPostBack)
            lnkAdd.NavigateUrl = "~/Authenticated/BlogComments/Edit.aspx?blogId=" + Request.QueryString["blogId"];
    }

    protected void srcBlog_Deleted(object sender, ObjectDataSourceStatusEventArgs e)
    {
        Response.Redirect("~/Default.aspx");
    }


    protected void frmBlog_DataBound(object sender, EventArgs e)
    {
        BlogAuthorUserName = ((FullBlog)frmBlog.DataItem).AuthorUserName;            
    }
    
    string ShowAuthorCssClass(string commentAuthorUserName)
    {
        if (String.Compare(commentAuthorUserName, BlogAuthorUserName, true) == 0)
            return "divBlogCommentByBlogAuthor";
        return String.Empty;
    }
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

<asp:FormView
    id="frmBlog"
    DataKeyNames="Id,Version"
    DataSourceId="srcBlog"
    Runat="server" OnDataBound="frmBlog_DataBound">
    <ItemTemplate>
    
    <h1>
    <asp:Literal
        id="ltlTitle"
        Text='<%# Eval("Title") %>'
        Mode="Encode"
        Runat="server" />
    </h1>
    
    <div>
        <%# Eval("Post") %>
    </div>
    
    <div class="metaInfo">
        Posted: <user:UserView ID="UserView1" runat="server" /> on <%# Eval("DateCreated", "{0:D}") %> | <%# Eval("CommentCount") %> Comments<br />
        <user:BlogTagView
            id="BlogTagView1"
            BlogId='<%# Eval("Id") %>'
            Runat="server" />    
    </div>
    
    <asp:HyperLink
        id="lnkEdit"
        Text="{Edit}"
        NavigateUrl='<%# Eval("Id", "~/Admin/Blog/Edit.aspx?blogId={0}") %>'
        Visible='<%# User.IsInRole("Administrators") %>'
        Runat="server" />
    
    <asp:LinkButton
        id="lnkDelete"
        Text="{Delete}"
        CommandName="Delete"
        Visible='<%# User.IsInRole("Administrators") %>'
        OnClientClick="return confirm('Delete blog?')"
        Runat="server" />
    
    </ItemTemplate>    
</asp:FormView>

<asp:ObjectDataSource
    id="srcBlog"
    TypeName="Blog"
    DataObjectTypeName="Blog"
    SelectMethod="GetFull"
    DeleteMethod="Delete"
    OnDeleted="srcBlog_Deleted"
    Runat="server">
    <SelectParameters>
        <asp:QueryStringParameter Name="Id" QueryStringField="blogId" />
    </SelectParameters>
</asp:ObjectDataSource>




<asp:ListView
    id="lstComments"
    DataSourceID="srcBlogComments"
    DataKeyNames="Id,Version"
    Runat="server">
    <LayoutTemplate>
        <span class="commentsTitle">Comments</span>
        <div>
        <asp:PlaceHolder
            id="itemPlaceholder" 
            runat="server" />
        </div> 
        <div class="dataPager">
            <asp:DataPager
                id="DataPager1"
                PageSize="10"
                runat="server">
                <Fields>
                    <asp:NumericPagerField />
                </Fields>
            </asp:DataPager>   
        </div> 
    </LayoutTemplate>
    <ItemTemplate>
    <div class='divBlogComment <%# ShowAuthorCssClass((string)Eval("AuthorUserName")) %>'>
     
        <h3>
            <%# Eval("Title") %>
        </h3>
        
        <p>
            <%# Eval("Comment") %>
        </p>
        
        <div class="metaInfo">
            Post: <user:UserView ID="UserView1" runat="server" />on <%# Eval("DateCreated", "{0:D}") %>    
        </div>
        <asp:HyperLink
            id="lnkEdit"
            Text="{Edit}"
            NavigateUrl='<%# Eval("Id", "~/Authenticated/BlogComments/Edit.aspx?id={0}")%>'
            Visible='<%# User.IsInRole("Administrators") %>'
            Runat="server" />

        <asp:LinkButton
            id="lnkDelete"
            Text="{Delete}"
            CommandName="Delete"
            OnClientClick="return confirm('Delete blog comment?')"
            Visible='<%# User.IsInRole("Administrators") %>'
            Runat="server" />
    </div>
    </ItemTemplate>
</asp:ListView>




<br />

<asp:HyperLink
    id="lnkAdd"
    Text="Add Blog Comment"
    Runat="server" />



<super:EntityDataSource
    id="srcBlogComments"
    TypeName="BlogComment"
    EnablePaging="true"
    Runat="server">
    <SelectParameters>
        <asp:QueryStringParameter Name="blogId" QueryStringField="blogId" />
    </SelectParameters>
</super:EntityDataSource>    
    
    

</asp:Content>

