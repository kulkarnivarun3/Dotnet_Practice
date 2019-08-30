<%@ Page Language="C#" MasterPageFile="~/PropertyMaster.master" %>
<%@ MasterType VirtualPath="~/PropertyMaster.master" %>
<script runat="server">

    void Page_Load()
    {
        if (!Page.IsPostBack)
        {
            Master.BodyTitle = "The Body Title";
        }
    }
</script>
<asp:Content 
    ID="Content1" 
    ContentPlaceHolderID="ContentPlaceHolder1" 
    Runat="Server">
    Content, Content, Content, Content
    <br />Content, Content, Content, Content
    <br />Content, Content, Content, Content
    <br />Content, Content, Content, Content
    <br />Content, Content, Content, Content
</asp:Content>

