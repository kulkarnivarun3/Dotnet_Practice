<%@ Page Language="C#" %>
<%@ Import Namespace="System.Security.Cryptography" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    void Page_Load()
    {
        lblAES.Text = GetSequence(64);
        lblSHA1.Text = GetSequence(128);
    }

    private string GetSequence(int length)
    {
        byte[] buffer = new byte[length/2];
        RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
        provider.GetBytes(buffer);
        StringBuilder builder = new StringBuilder(length);
        for (int i = 0; i < buffer.Length; i++)
            builder.Append(string.Format("{0:X2}", buffer[i]));
        return builder.ToString(); 
    }
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
