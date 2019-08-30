<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show AddHandler</title>
    <script type="text/javascript">
    
      function pageLoad() 
      {
        $addHandler( $get("btn"), "click", doSomething);
    
        Sys.Application.add_disposing(appDispose);
      }
    
      function doSomething()
      {
        alert("Hello World!");
      }  
    
      function appDispose()
      {
        $removeHandler( $get("btn"), "click", doSomething);
      }  
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    
    <input id="btn" type="button" value="Do Something" />
    
    </form>
</body>
</html>
