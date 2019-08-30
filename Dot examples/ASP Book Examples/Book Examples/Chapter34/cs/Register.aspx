<%@ Page Language="C#" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>

<script runat="server">




    protected void btnInsert_Click(object sender, EventArgs e)
    {
        ValidationErrorCollection valErrors = new ValidationErrorCollection();
        
        // Check for required fields
        if (!ValidationUtility.SatisfiesRequired(txtUserName.Text))
            valErrors.Add("UserName", "Required");
        if (!ValidationUtility.SatisfiesRequired(txtPassword.Text))
            valErrors.Add("Password", "Required");
        if (!ValidationUtility.SatisfiesRequired(txtConfirmPassword.Text))
            valErrors.Add("ConfirmPassword", "Required");
        if (!ValidationUtility.SatisfiesRequired(txtEmail.Text))
            valErrors.Add("Email", "Required");
        
        
        // Check for matching password and confirmpassword
        if (txtPassword.Text != txtConfirmPassword.Text)
            valErrors.AddIfNotAlready("Password", "Password and Confirm Password must match");
        
        // Check for valid email pattern
        if (!ValidationUtility.SatisfiesType(txtEmail.Text, "email"))
            valErrors.AddIfNotAlready("Email", "Invalid email address");
        
            
        // If no validation errors, register        
        if (valErrors.Count == 0)
        {
            MembershipCreateStatus status;
            Membership.CreateUser(txtUserName.Text, txtPassword.Text, txtEmail.Text, null, null, true, out status);
            
            if (status == MembershipCreateStatus.Success)
            {
                FormsAuthentication.SetAuthCookie(txtUserName.Text, false);
                Response.Redirect("~/Authenticated/Profile/Edit.aspx");
            }
            else
            {
                switch (status)
                {
                    case MembershipCreateStatus.DuplicateUserName:
                        valErrors.Add("UserName", "Duplicate user name, please enter a different user name");
                        break;
                    case MembershipCreateStatus.DuplicateEmail:
                        valErrors.Add("Email", "Duplicate email, please enter a different email address");
                        break;
                    default:
                        valErrors.Add("UserName", "Could not create new user: " + status.ToString());
                        break;
                }
            }
        }
        
        // show validation errors
        ValidationUtility.ShowValidationErrors(this, valErrors);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">


            
        <div class="field">
            <div class="fieldLabel">
            <asp:Label 
                ID="lblUserName"
                Text="User Name:" 
                AssociatedControlID="txtUserName"
                runat="server" />
            </div>
            <div class="fieldValue">    
            <asp:TextBox 
                ID="txtUserName" 
                runat="server" />
            </div>    
            <div class="fieldValue">    
            <super:EntityCallOutValidator
                id="valUserName"
                PropertyName="UserName"
                Runat="server" />
            </div>    
        </div>

        
        <div class="field">
            <div class="fieldLabel">
            <asp:Label 
                ID="lblPassword"
                Text="Password:" 
                AssociatedControlID="txtPassword"
                runat="server" />
            <ajaxToolkit:PasswordStrength 
                ID="PasswordStrength1" 
                runat="server" 
                TargetControlID="txtPassword"
                DisplayPosition="BelowLeft"
                StrengthIndicatorType="Text"
                PreferredPasswordLength="10"
                PrefixText="Strength:"
                HelpStatusLabelID="TextBox1_HelpLabel"
                TextStrengthDescriptions="Very Poor;Weak;Average;Strong;Excellent"
                TextStrengthDescriptionStyles="TextIndicator_TextBox1_Strength1;TextIndicator_TextBox1_Strength2;TextIndicator_TextBox1_Strength3;TextIndicator_TextBox1_Strength4;TextIndicator_TextBox1_Strength5"
                MinimumNumericCharacters="0"
                MinimumSymbolCharacters="0"
                RequiresUpperAndLowerCaseCharacters="false" />
            </div>
            <div class="fieldValue">    
            <asp:TextBox 
                ID="txtPassword" 
                TextMode="Password"
                runat="server" />
            </div>    
            <div class="fieldValue">    
            <super:EntityCallOutValidator
                id="valPassword"
                PropertyName="Password"
                Runat="server" />
            </div>    
        </div>

        <div class="field">
            <div class="fieldLabel">
            <asp:Label 
                ID="lblConfirmPassword"
                Text="Confirm Password:" 
                AssociatedControlID="txtConfirmPassword"
                runat="server" />
            </div>
            <div class="fieldValue">    
            <asp:TextBox 
                TextMode="Password"
                ID="txtConfirmPassword" 
                runat="server" />
            </div>    
            <div class="fieldValue">    
            <super:EntityCallOutValidator
                id="valConfirmPassword"
                PropertyName="ConfirmPassword"
                Runat="server" />
            </div>    
        </div>

        <div class="field">
            <div class="fieldLabel">
            <asp:Label 
                ID="lblEmail"
                Text="Email:" 
                AssociatedControlID="txtEmail"
                runat="server" />
            </div>
            <div class="fieldValue">    
            <asp:TextBox 
                ID="txtEmail" 
                runat="server" />
            </div>    
            <div class="fieldValue">    
            <super:EntityCallOutValidator
                id="valEmail"
                PropertyName="Email"
                Runat="server" />
            </div>    
        </div>

        <div class="field">
            <div class="fieldLabel">
            <div class="fieldValue">    
            <asp:Button
                id="btnInsert"
                Text="Register"
                CommandName="Insert"
                Runat="server" OnClick="btnInsert_Click" />
            </div>    
        </div>

                
 

</asp:Content>

