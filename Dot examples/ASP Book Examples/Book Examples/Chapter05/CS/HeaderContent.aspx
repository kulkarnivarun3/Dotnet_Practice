<%@ Page Language="C#" MasterPageFile="~/SimpleMaster.master" %>
<script runat="server">

    void Page_Load()
    {
        // Change the title
        Page.Header.Title = String.Format("Header Content ({0})", DateTime.Now);

        // Change the background color    
        Style myStyle = new Style();
        myStyle.BackColor = System.Drawing.Color.Red;
        Page.Header.StyleSheet.CreateStyleRule(myStyle, null, "html");
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

