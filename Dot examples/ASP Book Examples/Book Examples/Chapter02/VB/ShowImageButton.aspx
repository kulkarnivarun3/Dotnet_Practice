<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub btnSubmit_Click(ByVal sender As Object, ByVal e As ImageClickEventArgs)
        lblResults.Text = "First Name: " & txtFirstName.Text
        lblResults.Text &= "<br />Last Name: " & txtLastName.Text
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show ImageButton</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblFirstName"
        Text="First Name:"
        AssociatedControlID="txtFirstName"
        Runat="server" />
    <br />
    <asp:TextBox
        id="txtFirstName"
        Runat="server" />
    <br /><br />    
    <asp:Label
        id="lblLastName"
        Text="Last Name:"
        AssociatedControlID="txtLastName"
        Runat="server" />
    <br />
    <asp:TextBox
        id="txtLastName"
        Runat="server" />
    <br /><br />
    <asp:ImageButton
        id="btnSubmit"
        ImageUrl="Submit.gif"
        AlternateText="Submit Form"
        Runat="server" OnClick="btnSubmit_Click" />

    <br /><br />
    <asp:Label
        id="lblResults"
        Runat="server" />
            
    </div>
    </form>
</body>
</html>
