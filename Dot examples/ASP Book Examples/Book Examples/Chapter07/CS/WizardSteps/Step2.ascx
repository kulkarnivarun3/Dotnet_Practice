<%@ Control Language="C#" ClassName="Step2" %>
<%@ Implements Interface="IWizardStep" %>
<script runat="server">

    public void LoadStep()
    {
        if (Session["FavoriteColor"] != null)
            txtFavoriteColor.Text = (string)Session["FavoriteColor"];
    }

    public bool NextStep()
    {
        if (Page.IsValid)
        {
            Session["FavoriteColor"] = txtFavoriteColor.Text;
            return true;
        }
        return false;
    }
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