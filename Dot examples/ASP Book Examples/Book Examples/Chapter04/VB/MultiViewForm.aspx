<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub View3_Activate(ByVal sender As Object, ByVal e As EventArgs)
        lblFirstNameResult.Text = txtFirstName.Text
        lblColorResult.Text = txtColor.Text
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>MultiView Form</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:MultiView
        id="MultiView1"
        ActiveViewIndex="0"
        Runat="server">
        <asp:View ID="View1" runat="server">
        <h1>Step 1</h1>
        <asp:Label
            id="lblFirstName"
            Text="Enter Your First Name:"
            AssociatedControlID="txtFirstName"
            Runat="server" />
        <br />
        <asp:TextBox
            id="txtFirstName"
            Runat="server" />
            
        <br /><br />
        
        <asp:Button
            id="btnNext"
            Text="Next"
            CommandName="NextView"
            Runat="server" />    
        
        </asp:View>    
        <asp:View ID="View2" runat="server">
        <h1>Step 2</h1>
        <asp:Label
            id="Label1"
            Text="Enter Your Favorite Color:"
            AssociatedControlID="txtColor"
            Runat="server" />
        <br />
        <asp:TextBox
            id="txtColor"
            Runat="server" />
            
        <br /><br />
        
        <asp:Button
            id="Button1"
            Text="Next"
            CommandName="NextView"
            Runat="server" />    
        
        </asp:View>    
        <asp:View ID="View3" runat="server" OnActivate="View3_Activate">
        <h1>Summary</h1>
        Your First Name:
        <asp:Label
            id="lblFirstNameResult"
            Runat="server" />
        <br /><br />
        Your Favorite Color:
        <asp:Label
            id="lblColorResult"
            Runat="server" />
        </asp:View>
    </asp:MultiView>
    
    </div>
    </form>
</body>
</html>
