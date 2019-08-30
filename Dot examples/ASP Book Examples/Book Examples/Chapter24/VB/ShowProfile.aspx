<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    Private Sub Page_PreRender()
        lblFirstname.Text = Profile.firstName
        lblLastName.Text = Profile.lastName
 
        Profile.numberOfVisits = Profile.numberOfVisits + 1
        lblNumberOfVisits.Text = Profile.numberOfVisits.ToString()
    End Sub
 
    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As EventArgs)
        Profile.firstName = txtNewFirstName.Text
        Profile.lastName = txtNewLastName.Text
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Profile</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    First Name:
    <asp:Label
        id="lblFirstname"
        Runat="server" />
    <br /><br />
    Last Name:
    <asp:Label
        id="lblLastName"
        Runat="server" />
    <br /><br />
    Number of Visits:
    <asp:Label
        id="lblNumberOfVisits"
        Runat="server" />
        
    <hr />
    
    <asp:Label
        id="lblNewFirstName"
        Text="New First Name:"
        AssociatedControlID="txtNewFirstName"
        Runat="server" />
    <asp:TextBox
        id="txtNewFirstName"
        Runat="server" />
    <br /><br />
    <asp:Label
        id="lblNewLastName"
        Text="New Last Name:"
        AssociatedControlID="txtNewLastName"
        Runat="server" />
    <asp:TextBox
        id="txtNewLastName"
        Runat="server" />
    <br /><br />    
    <asp:Button
        id="btnUpdate"
        Text="Update Profile"
        OnClick="btnUpdate_Click" 
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
