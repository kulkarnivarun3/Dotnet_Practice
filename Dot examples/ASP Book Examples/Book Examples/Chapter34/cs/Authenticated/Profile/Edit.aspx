<%@ Page Language="C#" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>

<script runat="server">

    protected void srcWebUser_Updating(object sender, ObjectDataSourceMethodEventArgs e)
    {
        WebUser newUser = (WebUser)e.InputParameters[1];
        newUser.UserName = User.Identity.Name;
    }

    protected void frmProfile_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        if (e.Exception == null)
        {
            Response.Redirect("~/Default.aspx");
        }
        else
        {
            e.ExceptionHandled = true;
            e.KeepInEditMode = true;
            ValidationUtility.ShowValidationErrors(this, e.Exception);
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

    <asp:UpdatePanel ID="up1" runat="server">
    <ContentTemplate>
    <asp:FormView 
        ID="frmProfile" 
        DataSourceID="srcWebUser"
        DefaultMode="Edit"
        runat="server" OnItemUpdated="frmProfile_ItemUpdated">
        <EditItemTemplate>
                

        <div class="field">
            <div class="fieldLabel">
            <asp:Label 
                ID="lblFirstName"
                Text="First Name:" 
                AssociatedControlID="txtFirstName"
                runat="server" />
            </div>
            <div class="fieldValue">    
            <asp:TextBox 
                ID="txtFirstName"
                Text='<%# Bind("FirstName") %>' 
                runat="server" />
            </div>    
            <div class="fieldValue">    
            <super:EntityCallOutValidator
                id="valFirstName"
                PropertyName="FirstName"
                Runat="server" />
            </div>
        </div>


        <div class="field">
            <div class="fieldLabel">
            <asp:Label 
                ID="lblLastName"
                Text="Last Name:" 
                AssociatedControlID="txtLastName"
                runat="server" />
            </div>
            <div class="fieldValue">    
            <asp:TextBox 
                ID="txtLastName" 
                Text='<%# Bind("LastName") %>'
                runat="server" />
            </div>    
            <div class="fieldValue">    
            <super:EntityCallOutValidator
                id="valLastName"
                PropertyName="LastName"
                Runat="server" />
            </div>
        </div>


        <div class="field">
            <div class="fieldLabel">
            <asp:Label 
                ID="lblReceiveNewsletter"
                Text="Receive Newsletter:" 
                AssociatedControlID="chkReceiveNewsletter"
                runat="server" />
            </div>
            <div class="fieldValue">    
            <asp:CheckBox 
                ID="chkReceiveNewsletter"
                Checked='<%# Bind("ReceiveNewsletter") %>' 
                runat="server" />
            </div>    
        </div>

        <div class="field">
            <div class="fieldLabel">
            <asp:Label 
                ID="lblWebsiteUrl"
                Text="Website Url:" 
                AssociatedControlID="txtWebsiteUrl"
                runat="server" />
            </div>
            <div class="fieldValue">    
            <asp:TextBox 
                ID="txtWebsiteUrl" 
                Text='<%# Bind("WebsiteUrl") %>'
                runat="server" />
            </div>    
            <div class="fieldValue">    
            <super:EntityCallOutValidator
                id="valWebsiteUrl"
                PropertyName="WebsiteUrl"
                Runat="server" />
            </div>
        </div>

        
        <div class="field">
            <div class="fieldLabel">
            <asp:Label
                id="lblProfile"
                Text="Profile:"
                AssociatedControlID="txtProfile"
                Runat="server" />
            </div>
            <div class="fieldValue">
            <fck:FCKeditor
                id="txtProfile" 
                BasePath="~/FCKEditor/"
                ToolbarSet="Superexpert"
                Width="600px"
                Height="300px"
                Value='<%# Bind("Profile") %>'
                runat="server" />
            </div>
        </div>
                
        <div class="field">
            <div class="fieldLabel">
            </div>
            <div class="fieldValue">
            <asp:Button
                id="btnSave"
                CommandName="Update"
                Text="Save"
                Runat="server" />
            </div>
        </div>
 
 
    </EditItemTemplate>
    </asp:FormView>
    </ContentTemplate>
    </asp:UpdatePanel>
 
    <super:EntityDataSource
        id="srcWebUser"
        TypeName="WebUser"
        SelectMethod="Get"
        UpdateMethod="Save"
        OnUpdating="srcWebUser_Updating"
        Runat="server" >
        <SelectParameters>
        <super:UserNameParameter Name="UserName" />
        </SelectParameters>    
    </super:EntityDataSource>    
 

</asp:Content>


