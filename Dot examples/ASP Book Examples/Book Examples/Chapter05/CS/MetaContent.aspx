<%@ Page Language="C#" MasterPageFile="~/SimpleMaster.master" %>

<script runat="server">

    void Page_Load()
    {
        // Create Meta Description
        HtmlMeta metaDesc = new HtmlMeta();
        metaDesc.Name = "DESCRIPTION";
        metaDesc.Content = "A sample of using HtmlMeta controls";
        
        // Create Meta Keywords
        HtmlMeta metaKeywords = new HtmlMeta();
        metaKeywords.Name = "KEYWORDS";
        metaKeywords.Content = "HtmlMeta,Page.Header,ASP.NET";
        
        // Add Meta controls to HtmlHead
        HtmlHead head = (HtmlHead)Page.Header;
        head.Controls.Add(metaDesc);
        head.Controls.Add(metaKeywords);
    }

</script>


<asp:Content 
    ID="Content1" 
    ContentPlaceHolderID="ContentPlaceHolder1" 
    Runat="Server">
    Content in the first column
    <br />Content in the first column
    <br />Content in the first column
    <br />Content in the first column
    <br />Content in the first column
</asp:Content>

<asp:Content 
    ID="Content2" 
    ContentPlaceHolderID="ContentPlaceHolder2" 
    Runat="Server">
    Content in the second column
    <br />Content in the second column
    <br />Content in the second column
    <br />Content in the second column
    <br />Content in the second column
</asp:Content>


