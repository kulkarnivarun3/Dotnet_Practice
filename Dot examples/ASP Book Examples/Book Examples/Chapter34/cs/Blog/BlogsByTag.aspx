<%@ Page Language="C#" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>
<%@ Register TagPrefix="user" TagName="BriefBlogView" Src="~/UserControls/BriefBlogView.ascx" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

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
        <asp:DataPager
            id="DataPager1"
            PageSize="2"
            runat="server">
            <Fields>
                <asp:NumericPagerField />
            </Fields>
        </asp:DataPager>    
    </LayoutTemplate>    
    <ItemTemplate>
        <user:BriefBlogView
            id="BriefBlogView1"
            BlogId='<%# Eval("Id") %>'
            Runat="server" />       
    </ItemTemplate>
</asp:ListView>

<asp:ObjectDataSource
    id="srcBlog"
    TypeName="Blog"
    SelectMethod="SelectBriefByTag"
    SelectCountMethod="SelectBriefCountByTag"
    EnablePaging="true"
    Runat="server">
    <SelectParameters>
        <asp:QueryStringParameter Name="tagName" QueryStringField="tagName" />
    </SelectParameters>
</asp:ObjectDataSource>



</asp:Content>

