<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show AddHandlers</title>
    <style type="text/css">
        .glow
        {
            background-color:yellow;
        }
    </style>
 
    <script type="text/javascript">
    
      var divHover;
    
      function pageLoad() 
      {
        divHover = $get("divHover");
        $addHandlers( divHover, {mouseover:addGlow, mouseout:removeGlow} );
      
        Sys.Application.add_disposing(appDispose);
      }
    
      function addGlow()
      {
        Sys.UI.DomElement.addCssClass(divHover, "glow");
      }
      
      function removeGlow()
      {
        Sys.UI.DomElement.removeCssClass(divHover, "glow");  
      }    
    
      function appDispose()
      {
        $clearHandlers( divHover );
      }  

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div id="divHover">
    
        <h1>Hover Here!</h1>
    
    </div>
    </form>
</body>
</html>
