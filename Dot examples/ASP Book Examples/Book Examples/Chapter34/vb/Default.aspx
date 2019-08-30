<%@ Page Language="vb" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>
<%@ Register TagPrefix="user" TagName="BriefBlogView" Src="~/UserControls/BriefBlogView.ascx" %>
<%@ Register TagPrefix="user" TagName="CodeCloud" Src="~/UserControls/CodeCloud.ascx" %>

<script runat="server">

    Sub Page_Load()
        lnkBlogAdd.Visible = User.IsInRole("Administrators")
    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

    <div class="column">

        <h1>Code Cloud</h1>

        <user:CodeCloud
            id="CodeCloud1"
            Runat="Server" />       

    </div>

    <div class="column">
    
        <h1>News</h1>
    
        <asp:UpdatePanel    
            id="pnl"
            runat="server">
            <ContentTemplate>

        <asp:ListView
            id="lstBlog"
            DataSourceId="srcBlog"
            Runat="server">
            <LayoutTemplate>
                <div>
                <asp:PlaceHolder 
                    id="itemPlaceholder" 
                    runat="server" />
                </div>
                <div class="dataPager">
                    <asp:DataPager
                        id="DataPager1"
                        PageSize="3"
                        runat="server">
                        <Fields>
                            <asp:NumericPagerField />
                        </Fields>
                    </asp:DataPager>   
                </div> 
            </LayoutTemplate>    
            <ItemTemplate>
                <user:BriefBlogView
                    id="BriefBlogView1"
                    BlogId='<%# Eval("Id") %>'
                    Runat="server" />       
            </ItemTemplate>
        </asp:ListView>

        </ContentTemplate>
        </asp:UpdatePanel>



        <asp:ObjectDataSource
            id="srcBlog"
            TypeName="Blog"
            SelectMethod="SelectBrief"
            SelectCountMethod="SelectCountCached"
            EnablePaging="true"
            Runat="server" />
        <br />
        <asp:HyperLink 
            id="lnkBlogAdd"
            Text="{Add Blog Entry}"
            NavigateUrl="~/Admin/Blog/Edit.aspx"
            Runat="server" />

    </div>

</asp:Content>
