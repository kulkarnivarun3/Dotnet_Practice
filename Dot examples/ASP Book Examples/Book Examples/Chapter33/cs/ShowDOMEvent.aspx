<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show DOM Event</title>
    <style type="text/css">
        #divMenu
        {
            padding: 5px;
        }
        #divMenu span
        {
            margin: 4px;
            padding: 3px;
            border:solid 1px black;
            background-color: #eeeeee;
        }
    </style>
    <script type="text/javascript">
    
      function pageLoad() 
      {
        $addHandler( $get("divMenu"), "click", selectMenuItem );
        Sys.Application.add_disposing(appDispose);      
      }
      
      function selectMenuItem(e)
      {
        if (e.target.tagName === "SPAN")
            $get("spanSelection").innerHTML = e.target.innerHTML;
      }
        
      function appDispose()
      {
        $clearHandlers( $get("divMenu") );
      }  

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    
    <div id="divMenu">
    
        <span>Cheeseburger</span>
    
        <span>Milkshake</span>
        
        <span>French fries</span>
        
    </div>
    
    <br /> You selected:
    <span id="spanSelection"></span>
    
    </form>
</body>
</html>
