<%@ Page Language="VB" MasterPageFile="~/SimpleMaster.master" %>
<script runat="server">

    Private Sub Page_Load()
        ' Create Meta Description
        Dim metaDesc As New HtmlMeta()
        metaDesc.Name = "DESCRIPTION"
        metaDesc.Content = "A sample of using HtmlMeta controls"
 
        ' Create Meta Keywords
        Dim metaKeywords As New HtmlMeta()
        metaKeywords.Name = "KEYWORDS"
        metaKeywords.Content = "HtmlMeta,Page.Header,ASP.NET"
 
        ' Add Meta controls to HtmlHead
        Dim head As HtmlHead = CType(Page.Header, HtmlHead)
        head.Controls.Add(metaDesc)
        head.Controls.Add(metaKeywords)
    End Sub
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


