<%@ Control Language="VB" ClassName="Step2" %>
<%@ Implements Interface="IWizardStep" %>
<script runat="server">

    Public Sub LoadStep() Implements IWizardStep.LoadStep
        If Not IsNothing(Session("FavoriteColor")) Then
            txtFavoriteColor.Text = CStr(Session("FavoriteColor"))
        End If
    End Sub

    Public Function NextStep() As Boolean Implements IWizardStep.NextStep
        If Page.IsValid Then
            Session("FavoriteColor") = txtFavoriteColor.Text
            Return True
        End If
        Return False
    End Function
</script>

<h1>Step 2</h1>

<asp:Label
    id="lblFavoriteColor"
    Text="Favorite Color:"
    AssociatedControlID="txtFavoriteColor"
    Runat="server" />
<asp:RequiredFieldValidator
    id="reqFavoriteColor"
    Text="(required)"
    ControlToValidate="txtFavoriteColor"
    Runat="server" />    
<br />
<asp:TextBox
    id="txtFavoriteColor"
    Runat="server" />    