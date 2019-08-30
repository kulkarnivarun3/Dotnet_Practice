<%@ Page Language="vb" %>
<%@ Import Namespace="System.Security.Cryptography" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
 
    Private Sub Page_Load()
        lblAES.Text = GetSequence(64)
        lblSHA1.Text = GetSequence(128)
    End Sub
 
    Private Function GetSequence(ByVal length As Integer) As String
        Dim buffer() As Byte = New Byte(length / 2) {}
        Dim provider As RNGCryptoServiceProvider = New RNGCryptoServiceProvider()
        provider.GetBytes(buffer)
        Dim builder As StringBuilder = New StringBuilder(length)
        Dim i As Integer
        For i = 0 To buffer.Length - 1 Step i + 1
            builder.Append(String.Format("{0:X2}", buffer(i)))
        Next
        Return builder.ToString()
    End Function


</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Generate Keys</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    AES:
    <asp:Label
        id="lblAES"
        Runat="server" />
    <br /><br />
    SHA1:
    <asp:Label
        id="lblSHA1"
        Runat="server" />

    </div>
    </form>
</body>
</html>
