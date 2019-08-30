﻿<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show Namespaces</title>
    <script type="text/javascript">
    
      function pageLoad() 
      {
        var myClass = new MyNamespace.MyClass();
        myClass.sayMessage(); 
      }
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Path="~/Namespaces.js" />
        </Scripts>
        </asp:ScriptManager>
    </div>
    </form>
</body>
</html>
