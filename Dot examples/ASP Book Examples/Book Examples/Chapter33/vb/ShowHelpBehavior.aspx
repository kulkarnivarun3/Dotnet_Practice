<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show Help Box</title>
    <script type="text/javascript">
    
      function pageLoad() 
      {
        $create
            (
                myControls.HelpBehavior,
                {text:"Enter your first name"},
                null,
                null,
                $get("txtFirstName")
            );

        $create
            (
                myControls.HelpBehavior,
                {text:"Enter your last name."},
                null,
                null,
                $get("txtLastName")
            );


      }
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Path="~/HelpBehavior.js" />
        </Scripts>
        </asp:ScriptManager>

        <label for="txtFirstName">First Name:</label>
        <input id="txtFirstName" />

        <br /><br />

        <label for="txtLastName">Last Name:</label>
        <input id="txtLastName" />

    </div>
    </form>
</body>
</html>
