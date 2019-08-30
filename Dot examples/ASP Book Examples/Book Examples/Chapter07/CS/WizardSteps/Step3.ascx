<%@ Control Language="C#" ClassName="Step3" %>
<%@ Implements Interface="IWizardStep" %>
<script runat="server">

    public void LoadStep()
    {
        lblFirstName.Text = (string)Session["FirstName"];
        lblLastName.Text = (string)Session["LastName"];
        lblFavoriteColor.Text = (string)Session["FavoriteColor"]; 
    }

    public bool NextStep()
    {
        return false;
    }
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