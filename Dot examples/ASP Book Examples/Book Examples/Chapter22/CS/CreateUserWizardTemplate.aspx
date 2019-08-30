<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>CreateUserWizard Template</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:CreateUserWizard
        id="CreateUserWizard1"
        Runat="server">
        <WizardSteps>
        <asp:CreateUserWizardStep>
        <ContentTemplate>
        <h1>Register</h1>
        
        <asp:Label
            id="ErrorMessage"
            ForeColor="Red"
            Runat="server" />
        
        <br /><br />
        <asp:Label
            id="lblUserName"
            Text="User Name:"
            AssociatedControlID="UserName"
            Runat="server" />
        <br />
        <asp:TextBox
            id="UserName"
            Runat="server" />
        
        <br /><br />
        <asp:Label
            id="lblPassword"
            Text="Password:"
            AssociatedControlID="Password"
            Runat="server" />
        <br />
        <asp:TextBox
            id="Password"
            TextMode="Password"
            Runat="server" />
        
        <br /><br />
        <asp:Label
            id="lblEmail"
            Text="Email:"
            AssociatedControlID="Email"
            Runat="server" />
        <br />
        <asp:TextBox
            id="Email"
            Runat="server" />

        <br /><br />
        <asp:Label
            id="lblQuestion"
            Text="Security Question:"
            AssociatedControlID="Question"
            Runat="server" />
        <br />
        <asp:DropDownList
            id="Question"
            Runat="server">
            <asp:ListItem 
                Text="Enter the name of your pet"
                Value="Pet Name" />
            <asp:ListItem 
                Text="Enter your favorite color"
                Value="Favorite Color" />
        </asp:DropDownList>
        
        <br /><br />
        <asp:Label
            id="lblAnswer"
            Text="Security Answer:"
            AssociatedControlID="Answer"
            Runat="server" />
        <br />
        <asp:TextBox
            id="Answer"
            Runat="server" />
        </ContentTemplate>
        </asp:CreateUserWizardStep>
        <asp:CompleteWizardStep>
        <ContentTemplate>
            Your account was successfully created.
        </ContentTemplate>    
        </asp:CompleteWizardStep>
        </WizardSteps>    
    </asp:CreateUserWizard>
    
    </div>
    </form>
</body>
</html>
