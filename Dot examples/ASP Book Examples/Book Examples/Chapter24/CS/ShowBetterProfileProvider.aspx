<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_PreRender()
    {
        Profile.NumberOfVisits++;
        lblNumberOfVisits.Text = Profile.NumberOfVisits.ToString();

        lblFirstName.Text = Profile.FirstName;
        lblLastName.Text = Profile.LastName;
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        Profile.FirstName = txtNewFirstName.Text;
        Profile.LastName = txtNewLastName.Text;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show BetterProfileProvider</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    Number of Visits:
    <asp:Label
        id="lblNumberOfVisits"
        Runat="server" />
    <br />
    First Name:
    <asp:Label
        id="lblFirstName"
        Runat="server" />
    <br />
    Last Name:
    <asp:Label
        id="lblLastName"
        Runat="server" />
    
    <hr />
    
    <asp:Label
        id="lblNewFirstName"
        Text="First Name:"
        AssociatedControlID="txtNewFirstName"
        Runat="server" />
    <asp:TextBox
        id="txtNewFirstName"
        Runat="server" />
    <br />
    <asp:Label
        id="lblNewLastname"
        Text="Last Name:"
        AssociatedControlID="txtNewLastName"
        Runat="server" />
    <asp:TextBox
        id="txtNewLastName"
        Runat="server" />
    <br />
    <asp:Button
        id="btnUpdate"
        Text="Update"
        OnClick="btnUpdate_Click"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
