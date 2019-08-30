<%@ Page Language="VB" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        lblResults.Text = String.Format("You submitted {0} and {1}", _
            LoginStandards1.UserName, LoginStandards1.Password)
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show LoginStandards</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <custom:LoginStandards
        ID="LoginStandards1"
        Runat="server" />
    
    <asp:Button
        id="btnSubmit"
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
