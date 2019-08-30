<%@ Page Language="VB" %>
<%@ Import Namespace="System.Drawing.Text" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Private Sub Page_Load()
        If Not Page.IsPostBack Then
            Dim fonts As New InstalledFontCollection()
            GridView1.DataSource = fonts.Families
            GridView1.DataBind()
        End If
    End Sub

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Fonts</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="GridView1"
        Runat="server" />

    </div>
    </form>
</body>
</html>
