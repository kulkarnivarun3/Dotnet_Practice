<%@ Page Language="VB" Trace="true" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        lblResults.Text = txtUserName.Text
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show RequiredTextBox</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        ID="lblUserName"
        Text="User Name:"
        AssociatedControlID="txtUserName"
        Runat="server" />
    
    <custom:RequiredTextBox
        ID="txtUserName"
        Runat="Server" />
    
    <br />
        
    <asp:Button
        ID="btnSubmit"
        Text="Submit"
        OnClick="btnSubmit_Click" 
        Runat="server" />
        
    <hr />
    
    <asp:Label
        id="lblResults"
        Runat="server" />        
    
    </div>
    </form>
</body>
</html>
