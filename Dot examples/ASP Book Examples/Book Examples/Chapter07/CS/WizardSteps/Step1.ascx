<%@ Control Language="C#" ClassName="Step1" %>
<%@ Implements Interface="IWizardStep" %>
<script runat="server">

    public void LoadStep()
    {
        if (Session["FirstName"] != null)
            txtFirstName.Text = (string)Session["FirstName"];
        if (Session["LastName"] != null)
            txtLastName.Text = (string)Session["LastName"];
    }

    public bool NextStep()
    {
        if (Page.IsValid)
        {
            
            Session["FirstName"] = txtFirstName.Text;
            Session["LastName"] = txtLastName.Text;
            return true;
        }
        return false;
    }
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
    
    