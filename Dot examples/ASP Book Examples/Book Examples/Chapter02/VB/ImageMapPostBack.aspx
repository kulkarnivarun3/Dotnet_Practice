<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub mapMenu_Click(ByVal sender As Object, ByVal e As ImageMapEventArgs)
        Select Case e.PostBackValue
            Case "ToUpper"
                txtText.Text = txtText.Text.ToUpper()
            Case "ToLower"
                txtText.Text = txtText.Text.ToLower()
            Case "Erase"
                txtText.Text = String.Empty
        End Select
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>ImageMap PostBack</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:ImageMap
        id="mapMenu"
        ImageUrl="MenuBar.gif"
        HotSpotMode="PostBack"
        Runat="server" OnClick="mapMenu_Click">
        <asp:RectangleHotSpot
            PostBackValue="ToUpper"
            Left="0"
            Top="0"
            Right="100"
            Bottom="30"
            AlternateText="To Uppercase" />
        <asp:RectangleHotSpot
            PostBackValue="ToLower"
            Left="100"
            Top="0"
            Right="200"
            Bottom="30"
            AlternateText="To Uppercase" />
        <asp:RectangleHotSpot
            PostBackValue="Erase"
            Left="200"
            Top="0"
            Right="300"
            Bottom="30"
            AlternateText="To Uppercase" />
    </asp:ImageMap>
    
    <br />
    
    <asp:TextBox
        id="txtText"
        TextMode="MultiLine"
        Columns="40"
        Rows="5"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
