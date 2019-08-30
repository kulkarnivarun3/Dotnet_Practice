<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show Product</title>
    <script type="text/javascript">
    
      function pageLoad() 
      {
        var myLapTop = new Laptop();
        var message = String.format("The {0} costs {1}", 
            myLapTop.get_name(), myLapTop.get_price().localeFormat("c")); 
        alert( message  );
      }
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Path="~/Product.js" />
        </Scripts>
        </asp:ScriptManager>
    </div>
    </form>
</body>
</html>
