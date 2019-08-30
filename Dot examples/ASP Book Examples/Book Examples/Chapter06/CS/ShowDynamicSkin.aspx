<%@ Page Language="C#" Theme="DynamicSkin" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (Request["skin"] != null)
        {
            switch (Request["skin"])
            {
                case "professional":
                    grdMovies.SkinID = "Professional";
                    break;
                case "colorful":
                    grdMovies.SkinID = "Colorful";
                    break;
            }
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
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
