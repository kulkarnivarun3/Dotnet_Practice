<%@ Page Language="C#" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        if (!Page.IsPostBack)
        {
            ControlStateControl1.ViewStateText = "Hello World!";
            ControlStateControl1.ControlStateText = "Hello World!";
        }
    }
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Control State</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <custom:ControlStateControl
        id="ControlStateControl1"
        EnableViewState="false"
        Runat="server" />
    
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
