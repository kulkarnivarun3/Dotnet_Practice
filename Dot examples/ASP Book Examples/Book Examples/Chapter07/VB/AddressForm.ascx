<%@ Control Language="VB" ClassName="AddressForm" %>
<script runat="server">
 
    Public Property Title() As String
    	Get 
        	 Return ltlTitle.Text
    	End Get
    	Set (ByVal Value As String) 
        	 ltlTitle.Text = value
    	End Set
    End Property
 
    Public Property Street() As String
    	Get 
        	 Return txtStreet.Text
    	End Get
    	Set (ByVal Value As String) 
        	 txtStreet.Text = value
    	End Set
    End Property
 
    Public Property City() As String
    	Get 
        	 Return txtCity.Text
    	End Get
    	Set (ByVal Value As String) 
        	 txtCity.Text = value
    	End Set
    End Property
 
    Public Property State() As String
    	Get 
        	 Return txtState.Text
    	End Get
    	Set (ByVal Value As String) 
        	 txtState.Text = value
    	End Set
    End Property
 
    Public Property PostalCode() As String
    	Get 
        	 Return txtPostalCode.Text
    	End Get
    	Set (ByVal Value As String) 
        	 txtPostalCode.Text = value
    	End Set
    End Property
   
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