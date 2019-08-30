<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Wizard1_FinishButtonClick(ByVal sender As Object, ByVal e As WizardNavigationEventArgs)
        lblSSNResult.Text = txtSSN.Text
        lblPhoneResult.Text = txtPhone.Text
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .wizard
        {
            border:solid 1px black;
            font:14px Verdana,Sans-Serif;
            width:400px;
            height:300px;
        }
        .header
        {
            color:gray;
            font:bold 18px Verdana,Sans-Serif;
        }
        .sideBar
        {
            background-color:#eeeeee;
            padding:10px;
            width:100px;
        }
        .sideBar a
        {
            text-decoration:none;
        }
        .step
        {
            padding:10px;
        }
    </style>
    <title>Show Wizard</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Wizard
        id="Wizard1"
        HeaderText="Product Survey"
        OnFinishButtonClick="Wizard1_FinishButtonClick"
        CssClass="wizard"
        HeaderStyle-CssClass="header"
        SideBarStyle-CssClass="sideBar"
        StepStyle-CssClass="step"
        Runat="server">
        <WizardSteps>
        <asp:WizardStep ID="WizardStep1" Title="Introduction">
        Please complete our survey so that we can improve our
        products.
        </asp:WizardStep>
        <asp:WizardStep ID="WizardStep2" Title="Step 1">
        <asp:Label
            id="lblSSN"
            Text="Social Security Number:"
            AssociatedControlID="txtSSN"
            Runat="server" />
        <br />
        <asp:TextBox
            id="txtSSN"
            Runat="server" />    
        </asp:WizardStep>
        <asp:WizardStep ID="WizardStep3" Title="Step 2" StepType="Finish">
        <asp:Label
            id="lblPhone"
            Text="Phone Number:"
            AssociatedControlID="txtPhone"
            Runat="server" />
        <br />
        <asp:TextBox
            id="txtPhone"
            Runat="server" />    
        </asp:WizardStep>
        <asp:WizardStep ID="WizardStep4" Title="Summary" StepType="Complete">
        <h1>Summary</h1>
        Social Security Number:
        <asp:Label
            id="lblSSNResult"
            Runat="server" />
        <br /><br />
        Phone Number:
        <asp:Label
            id="lblPhoneResult"
            Runat="server" />
        </asp:WizardStep>
        </WizardSteps>    
    </asp:Wizard>
    
    
    </div>
    </form>
</body>
</html>
