<%@ Page Language="VB" %>
<%@ Import Namespace="System.Drawing" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    Private  Sub Page_Load()
        ' Display Contact Info
        lblEmail.Text = Profile.ContactInfo.Email
        lblPhone.Text = Profile.ContactInfo.Phone
 
        ' Apply Preferences
        Dim pageStyle As New Style()
        pageStyle.BackColor = ColorTranslator.FromHtml(Profile.Preferences.BackColor)
        pageStyle.Font.Name = Profile.Preferences.Font
        Header.StyleSheet.CreateStyleRule(pageStyle, Nothing, "html")
    End Sub

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    Email:
    <asp:Label
        id="lblEmail"
        Runat="server" />
    <br /><br />
    Phone:
    <asp:Label
        id="lblPhone"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
