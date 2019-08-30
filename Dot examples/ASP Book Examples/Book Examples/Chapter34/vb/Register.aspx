<%@ Page Language="vb" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>

<script runat="server">


 
 
    Protected  Sub btnInsert_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim valErrors As ValidationErrorCollection =  New ValidationErrorCollection() 
 
        ' Check for required fields
        If Not ValidationUtility.SatisfiesRequired(txtUserName.Text) Then
            valErrors.Add("UserName", "Required")
        End If
        If Not ValidationUtility.SatisfiesRequired(txtPassword.Text) Then
            valErrors.Add("Password", "Required")
        End If
        If Not ValidationUtility.SatisfiesRequired(txtConfirmPassword.Text) Then
            valErrors.Add("ConfirmPassword", "Required")
        End If
        If Not ValidationUtility.SatisfiesRequired(txtEmail.Text) Then
            valErrors.Add("Email", "Required")
        End If
 
 
        ' Check for matching password and confirmpassword
        If txtPassword.Text <> txtConfirmPassword.Text Then
            valErrors.AddIfNotAlready("Password", "Password and Confirm Password must match")
        End If
 
        ' Check for valid email pattern
        If Not ValidationUtility.SatisfiesType(txtEmail.Text,"email") Then
            valErrors.AddIfNotAlready("Email", "Invalid email address")
        End If
 
 
        ' If no validation errors, register        
        If valErrors.Count = 0 Then
            Dim status As MembershipCreateStatus
            Membership.CreateUser(txtUserName.Text, txtPassword.Text, txtEmail.Text, Nothing, Nothing, True, status)
 
            If status = MembershipCreateStatus.Success Then
                FormsAuthentication.SetAuthCookie(txtUserName.Text, False)
                Response.Redirect("~/Authenticated/Profile/Edit.aspx")
            Else 
                Select Case status
                    Case MembershipCreateStatus.DuplicateUserName
                        valErrors.Add("UserName", "Duplicate user name, please enter a different user name")
                        Exit Sub
                    Case MembershipCreateStatus.DuplicateEmail
                        valErrors.Add("Email", "Duplicate email, please enter a different email address")
                        Exit Sub
                    Case Else
                        valErrors.Add("UserName", "Could not create new user: " + status.ToString())
                        Exit Sub
                End Select
            End If
        End If
 
        ' show validation errors
        ValidationUtility.ShowValidationErrors(Me, valErrors)
    End Sub

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

