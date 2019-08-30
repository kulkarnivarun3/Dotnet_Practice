<%@ Page Language="vb" %>
<%@ Register TagPrefix="custom" Namespace="MyControls" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show Custom Control Glow</title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    
        <custom:Glow 
            ID="Glow1" 
            Text="The First One"
            BackgroundColor="red"
            runat="server" />

        <br /><br />

        <custom:Glow 
            ID="Glow2" 
            Text="The Second One"
            BackgroundColor="yellow" 
            runat="server" />
    
    </form>
</body>
</html>
