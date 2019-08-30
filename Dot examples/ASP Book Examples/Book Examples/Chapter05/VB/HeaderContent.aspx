<%@ Page Language="VB" MasterPageFile="~/SimpleMaster.master" %>
<script runat="server">
 
    Private Sub Page_Load()
        ' Change the title
        Page.Header.Title = String.Format("Header Content ({0})", DateTime.Now)
 
        ' Change the background color    
        Dim myStyle As New Style()
        myStyle.BackColor = System.Drawing.Color.Red
        Page.Header.StyleSheet.CreateStyleRule(myStyle, Nothing, "html")
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

