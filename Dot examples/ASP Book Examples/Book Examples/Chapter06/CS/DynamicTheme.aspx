<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (Request["theme"] != null)
        {
            switch (Request["theme"])
            {
                case "Green":
                    Profile.userTheme = "GreenTheme";
                    break;
                case "Pink":
                    Profile.userTheme = "PinkTheme";
                    break;    
            }
        }
        Theme = Profile.userTheme;
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
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
