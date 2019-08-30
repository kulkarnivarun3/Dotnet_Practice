<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    Sub Page_PreInit(ByVal s As Object, ByVal e As EventArgs)
        If Not IsNothing(Request("theme")) Then
            Select Case (Request("theme"))
                Case "Green"
                    Profile.UserTheme = "GreenTheme"
                Case "Pink"
                    Profile.UserTheme = "PinkTheme"
            End Select
        End If
        Theme = Profile.UserTheme
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Dynamic Theme</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="content">
    
    <h1>Dynamic Theme</h1>

    Please select a Theme:
    <ul>
    <li>
        <a href="DynamicTheme.aspx?theme=Green">Green Theme</a>
    </li>
    <li>
        <a href="DynamicTheme.aspx?theme=Pink">Pink Theme</a>
    </li>
    </ul>
    
    </div>
    </form>
</body>
</html>
