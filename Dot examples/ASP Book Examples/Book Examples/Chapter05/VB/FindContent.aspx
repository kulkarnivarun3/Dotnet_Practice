<%@ Page Language="VB" MasterPageFile="~/FindMaster.master" %>
<script runat="server">
 
    Private Sub Page_Load()
        If Not Page.IsPostBack Then
            Dim ltlBodyTitle As Literal = CType(Master.FindControl("ltlBodyTitle"), Literal)
            ltlBodyTitle.Text = "The Body Title"
        End If
    End Sub
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

