<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show Glow Control</title>
    <script type="text/javascript">
    
      function pageLoad() 
      {
        $create
            (
                myControls.Glow, 
                {text: "Hello", backgroundColor: "orange"}, 
                null, 
                null, 
                $get("div1")
            );
      }
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Path="~/Glow.js" />
        </Scripts>
        </asp:ScriptManager>
    
        <div id="div1"></div>
    
    </div>
    </form>
</body>
</html>
