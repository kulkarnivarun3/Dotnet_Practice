<%@ Control Language="VB" ClassName="Step1" %>
<%@ Implements Interface="IWizardStep" %>
<script runat="server">
 
    Public Sub LoadStep() Implements IWizardStep.LoadStep
        If Not IsNothing(Session("FirstName")) Then
            txtFirstName.Text = CStr(Session("FirstName"))
        End If
        If Not IsNothing(Session("LastName")) Then
            txtLastName.Text = CStr(Session("LastName"))
        End If
    End Sub
 
    Public Function NextStep() As Boolean Implements IWizardStep.NextStep
        If Page.IsValid Then
            Session("FirstName") = txtFirstName.Text
            Session("LastName") = txtLastName.Text
            Return True
        End If
        Return False
    End Function
</script>
<h1>Step 1</h1>

<asp:Label
    id="lblFirstName"
    Text="First Name:"
    AssociatedControlID="txtFirstName"
    Runat="server" />
<asp:RequiredFieldValidator
    id="reqFirstName"
    Text="(required)"
    ControlToValidate="txtFirstName"
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
<asp:RequiredFieldValidator
    id="reqLastName"
    Text="(required)"
    ControlToValidate="txtLastName"
    Runat="server" />    
<br />
<asp:TextBox
    id="txtLastName"
    Runat="server" />    
    
    