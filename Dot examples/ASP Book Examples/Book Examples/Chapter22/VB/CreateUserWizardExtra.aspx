<%@ Page Language="VB" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Sub CreateUserWizard1_CreatedUser(ByVal sender As Object, ByVal e As EventArgs)
        CreateUserProfile(CreateUserWizard1.UserName, txtFirstName.Text, txtLastName.Text)
    End Sub

    Private Sub CreateUserProfile(ByVal userName As String, ByVal firstName As String, ByVal lastName As String)
        Dim conString As String = WebConfigurationManager.ConnectionStrings("UserProfiles").ConnectionString
        Dim con As New SqlConnection(conString)
        Dim cmd As New SqlCommand("INSERT UserProfiles (UserName,FirstName,LastName) VALUES (@UserName,@FirstName,@LastName)", con)
        cmd.Parameters.AddWithValue("@UserName", userName)
        cmd.Parameters.AddWithValue("@FirstName", firstName)
        cmd.Parameters.AddWithValue("@LastName", lastName)
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
        End Using
    End Sub
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>CreateUserWizard Extra</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:CreateUserWizard 
        id="CreateUserWizard1"
        OnCreatedUser="CreateUserWizard1_CreatedUser"
        Runat="server" >
        <WizardSteps>
        <asp:WizardStep>
            <asp:Label
                id="lblFirstName"
                Text="First Name:"
                AssociatedControlID="txtFirstName"
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
            <br />    
            <asp:TextBox
                id="txtLastName"
                Runat="server" />
        </asp:WizardStep>
        <asp:CreateUserWizardStep />
        </WizardSteps>    
    </asp:CreateUserWizard>
    
    </div>
    </form>
</body>
</html>
