<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_PreRender()
    {
        foreach (BaseValidator valControl in Page.Validators)
        {
            WebControl assControl = (WebControl)Page.FindControl(valControl.ControlToValidate);
            if (!valControl.IsValid)
                assControl.BackColor = System.Drawing.Color.Yellow;
            else
                assControl.BackColor = System.Drawing.Color.White;
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Validators</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
    <asp:Label
        id="lblFirstName"
        Text="First Name"
        AssociatedControlID="txtFirstName"
        Runat="server" />
    <br />    
    <asp:TextBox
        id="txtFirstName"
        Runat="server" />
    <asp:RequiredFieldValidator
        id="reqFirstName"
        ControlToValidate="txtFirstName"
        Text="(Required)"
        EnableClientScript="false"
        Runat="server" />   
     
    <br /><br />
        
    <asp:Label
        id="lblLastName"
        Text="Last Name"
        AssociatedControlID="txtLastName"
        Runat="server" />
    <br />    
    <asp:TextBox
        id="txtLastname"
        Runat="server" />
    <asp:RequiredFieldValidator
        id="reqLastName"
        ControlToValidate="txtLastName"
        Text="(Required)" 
        EnableClientScript="false"
        Runat="server" />   
     
     <br /><br />
     
     <asp:Button
        id="btnSubmit"
        Text="Submit"
        Runat="server" />   

    </div>
    </form>
</body>
</html>
