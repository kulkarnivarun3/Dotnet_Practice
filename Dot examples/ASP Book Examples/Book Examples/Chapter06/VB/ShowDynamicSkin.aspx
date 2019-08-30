<%@ Page Language="VB" Theme="DynamicSkin" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    Sub Page_PreInit(ByVal s As Object, ByVal e As EventArgs)
        If Not IsNothing(Request("skin")) Then
            Select Case Request("skin")
                Case "professional"
                    grdMovies.SkinID = "Professional"
                Case "colorful"
                    grdMovies.SkinID = "Colorful"
            End Select
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Dynamic Skin</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Runat="server" />
        
     <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director FROM Movies"   
        Runat="server" />
    
    <hr />
    
    <a href="showdynamicskin.aspx?skin=professional">Professional</a>
    &nbsp;|&nbsp;
    <a href="showdynamicskin.aspx?skin=colorful">Colorful</a>
    
    </div>
    </form>
</body>
</html>
