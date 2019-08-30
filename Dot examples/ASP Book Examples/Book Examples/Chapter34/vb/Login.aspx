<%@ Page Language="vb" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

    <asp:Login 
        ID="Login1" 
        CreateUserText="Register"
        CreateUserUrl="~/Register.aspx"
        runat="server" />


</asp:Content>

