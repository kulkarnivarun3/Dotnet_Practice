<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        Random rnd = new Random();
        switch (rnd.Next(3))
        {
            case 0:
                imgRandom.ImageUrl = "Picture1.gif";
                imgRandom.AlternateText = "Picture 1";
                break;
            case 1:
                imgRandom.ImageUrl = "Picture2.gif";
                imgRandom.AlternateText = "Picture 2";
                break;
            case 2:
                imgRandom.ImageUrl = "Picture3.gif";
                imgRandom.AlternateText = "Picture 3";
                break;
        }
    }
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Image</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Image
        id="imgRandom"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
