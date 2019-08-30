<%@ Page Language="C#" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void CustomLinkButton1_Click(object sender, EventArgs e)
    {
        lblResults.Text = txtUserName.Text;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show CustomLinkButton</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblUserName"
        Text="User Name:"
        AssociatedControlID="txtUserName"
        Runat="server" />
    <asp:TextBox
        id="txtUserName"
        Runat="server" />
        
    <br /><br />
    
    <custom:CustomLinkButton
        id="CustomLinkButton1"
        Text="Submit"
        OnClick="CustomLinkButton1_Click" 
        runat="server" />
    
    <hr />
    
    <asp:Label
        id="lblResults"
        EnableViewState="false"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
