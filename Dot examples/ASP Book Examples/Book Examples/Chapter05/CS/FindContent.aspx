<%@ Page Language="C#" MasterPageFile="~/FindMaster.master" %>
<script runat="server">

    void Page_Load()
    {
        if (!Page.IsPostBack)
        {
            Literal ltlBodyTitle = (Literal)Master.FindControl("ltlBodyTitle");
            ltlBodyTitle.Text = "The Body Title";
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

