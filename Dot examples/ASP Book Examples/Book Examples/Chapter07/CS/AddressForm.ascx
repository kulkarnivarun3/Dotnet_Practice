<%@ Control Language="C#" ClassName="AddressForm" %>
<script runat="server">

    public string Title
    {
        get { return ltlTitle.Text; }
        set { ltlTitle.Text = value; }
    }

    public string Street
    {
        get { return txtStreet.Text; }
        set { txtStreet.Text = value; }
    }

    public string City
    {
        get { return txtCity.Text; }
        set { txtCity.Text = value; }
    }

    public string State
    {
        get { return txtState.Text; }
        set { txtState.Text = value; }
    }

    public string PostalCode
    {
        get { return txtPostalCode.Text; }
        set { txtPostalCode.Text = value; }
    }
    
</script>

<fieldset>
<legend>
    <asp:Literal 
        ID="ltlTitle"
        Text="Address Form" 
        runat="server" />
</legend>

<div class="addressLabel">
<asp:Label  
    ID="lblStreet"
    Text="Street:"
    AssociatedControlID="txtStreet"
    Runat="server" />
</div>
<div class="addressField">
<asp:TextBox
    ID="txtStreet"
    Runat="server" />
<asp:RequiredFieldValidator
    ID="reqStreet"
    Text="(required)"
    ControlToValidate="txtStreet"
    Runat="server" />    
</div>

<br class="clear" />

<div class="addressLabel">
<asp:Label  
    ID="lblCity"
    Text="City:"
    AssociatedControlID="txtCity"
    Runat="server" />
</div>
<div class="addressField">
<asp:TextBox
    ID="txtCity"
    Runat="server" />
<asp:RequiredFieldValidator
    ID="reqCity"
    Text="(required)"
    ControlToValidate="txtCity"
    Runat="server" />    
</div>

<br class="clear" />

<div class="addressLabel">
<asp:Label  
    ID="lblState"
    Text="State:"
    AssociatedControlID="txtState"
    Runat="server" />
</div>
<div class="addressField">
<asp:TextBox
    ID="txtState"
    Runat="server" />
<asp:RequiredFieldValidator
    ID="reqState"
    Text="(required)"
    ControlToValidate="txtState"
    Runat="server" />    
</div>

<br class="clear" />

<div class="addressLabel">
<asp:Label  
    ID="lblPostalCode"
    Text="Postal Code:"
    AssociatedControlID="txtPostalCode"
    Runat="server" />
</div>
<div class="addressField">
<asp:TextBox
    ID="txtPostalCode"
    Runat="server" />
<asp:RequiredFieldValidator
    ID="RequiredFieldValidator1"
    Text="(required)"
    ControlToValidate="txtPostalCode"
    Runat="server" />    
</div>

<br class="clear" />

</fieldset>        