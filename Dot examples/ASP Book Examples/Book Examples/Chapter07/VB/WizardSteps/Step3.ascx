<%@ Control Language="VB" ClassName="Step3" %>
<%@ Implements Interface="IWizardStep" %>
<script runat="server">

    Public Sub LoadStep() Implements IWizardStep.LoadStep
        lblFirstName.Text = CStr(Session("FirstName"))
        lblLastName.Text = CStr(Session("LastName"))
        lblFavoriteColor.Text = CStr(Session("FavoriteColor"))
    End Sub

    Public Function NextStep() As Boolean Implements IWizardStep.NextStep
        Return False
    End Function
</script>

<h1>Step 3</h1>

First Name:
<asp:Label
    id="lblFirstName"
    Runat="server" />
<br />
Last Name:
<asp:Label
    id="lblLastName"
    Runat="server" />    
<br />
Favorite Color:
<asp:Label
    id="lblFavoriteColor"
    Runat="server" />    