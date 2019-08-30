<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void btnCancel_Click(Object sender, EventArgs e)
    {
        Response.Redirect("~/Default.aspx");
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Disable Validation</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:Label
        id="lblFirstName"
        Text="First Name:"
        AssociatedControlID="txtFirstName"
        Runat="server" />
    <asp:TextBox
        id="txtFirstName"
        Runat="server" />
    <asp:RequiredFieldValidator
        id="reqFirstName"
        ControlToValidate="txtFirstName"
        Text="(Required)"
        Runat="server" />
    <br /><br />
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        Runat="server" />
    <asp:Button
        id="btnCancel"
        Text="Cancel"
        OnClick="btnCancel_Click"
        CausesValidation="false"
        Runat="server" />
            
    </div>
    </form>
</body>
</html>
