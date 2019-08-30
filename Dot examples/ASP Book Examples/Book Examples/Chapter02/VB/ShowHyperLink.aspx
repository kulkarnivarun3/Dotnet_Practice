<%@ Page Language="VB" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        lnkRandom.NavigateUrl = GetRandomFile()
    End Sub

    Function GetRandomFile() As String
        Dim files As String() = Directory.GetFiles(MapPath(Request.ApplicationPath), "*.aspx")
        Dim rnd As New Random()
        Dim rndFile As String = files(rnd.Next(files.Length))
        Return Path.GetFileName(rndFile)
    End Function
        
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show HyperLink</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:HyperLink
        id="lnkRandom"
        Text="Random Link"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
