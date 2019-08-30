<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        Dim rnd As New Random()
        Select Case rnd.Next(3)
            Case 0
                imgRandom.ImageUrl = "Picture1.gif"
                imgRandom.AlternateText = "Picture 1"
            Case 1
                imgRandom.ImageUrl = "Picture2.gif"
                imgRandom.AlternateText = "Picture 2"
            Case 2
                imgRandom.ImageUrl = "Picture3.gif"
                imgRandom.AlternateText = "Picture 3"
        End Select
    End Sub
    
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
