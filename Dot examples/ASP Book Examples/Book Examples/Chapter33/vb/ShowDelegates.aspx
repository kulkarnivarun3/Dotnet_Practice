<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Show Delegates and Callbacks</title>
    <script type="text/javascript">
    
      function pageLoad() 
      {
        // Use $addHandler
        $addHandler($get("btnHandler"), "click", doSomething);
      
        // Use createCallback
        var callback = Function.createCallback(doSomething2, "apple");
        $addHandler($get("btnCallback"), "click", callback);
      
        // Use createDelegate
        var delegate = Function.createDelegate("apple", doSomething3);
        $addHandler($get("btnDelegate"), "click", delegate);
        
        // Use $addHandlers
        $addHandlers($get("btnHandlers"), {click: doSomething4}, "apple"); 
      }
    
      function doSomething(event)
      {
        alert( [this.id, event.type] );         
      }
    
      function doSomething2(event, context)
      {     
        alert( [this.id, event.type, context] ); 
      }
    
      function doSomething3(event)
      {
        alert( [this, event.type] );
      }

      function doSomething4(event)
      {
        alert( [this, event.type] );
      }
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    
    <input id="btnHandler" type="button" value="Handler" />
    <input id="btnCallback" type="button" value="Callback" />
    <input id="btnDelegate" type="button" value="Delegate" />
    <input id="btnHandlers" type="button" value="Handlers" />
    
    </form>
</body>
</html>
