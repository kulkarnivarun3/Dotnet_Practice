<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        lnkRandom.NavigateUrl = GetRandomFile();
    }

    string GetRandomFile()
    {
        string[] files = Directory.GetFiles(MapPath(Request.ApplicationPath), "*.aspx");
        Random rnd = new Random();
        string rndFile = files[rnd.Next(files.Length)];
        return Path.GetFileName(rndFile);
    }
        
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
