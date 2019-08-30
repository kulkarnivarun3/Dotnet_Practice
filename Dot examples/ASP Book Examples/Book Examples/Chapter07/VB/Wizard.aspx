<%@ Page Language="VB" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Private _wizardSteps As New List(Of String)()
    Private _currentStep As Control
 
    ''' <summary>
    ''' The current step in the Wizard
    ''' </summary>
    Public Property StepIndex() As Integer
    	Get 
            If (IsNothing(ViewState("StepIndex"))) Then
                Return 0
            else
                Return CInt(ViewState("StepIndex"))
            End If
    	End Get
    	Set (ByVal Value As Integer) 
            ViewState("StepIndex") = value
    	End Set
    End Property
 
    ''' <summary>
    ''' Load the list of wizard steps and load 
    ''' current step
    ''' </summary>
    Sub Page_Load()
        _wizardSteps.Add("~/WizardSteps/Step1.ascx")
        _wizardSteps.Add("~/WizardSteps/Step2.ascx")
        _wizardSteps.Add("~/WizardSteps/Step3.ascx")
 
        LoadWizardStep()
    End Sub
 
    ''' <summary>
    ''' Load the current wizard step
    ''' </summary>
    Private Sub LoadWizardStep()
        _currentStep = Page.LoadControl(_wizardSteps(StepIndex))
        _currentStep.ID = "ctlWizardStep"
        plhWizardStep.Controls.Clear()
        plhWizardStep.Controls.Add(_currentStep)
        CType(_currentStep, IWizardStep).LoadStep()
        ltlStep.Text = String.Format("Step {0} of {1}", StepIndex + 1, _wizardSteps.Count)
    End Sub
 
    ''' <summary>
    ''' Disable the Previous and Next
    ''' buttons when appropriate
    ''' </summary>
    Sub Page_PreRender()
        btnPrevious.Enabled = StepIndex > 0
        btnNext.Enabled = StepIndex < _wizardSteps.Count - 1
    End Sub
 
    ''' <summary>
    ''' Execute the step's NextStep() method
    ''' and move to the next step
    ''' </summary>
    Sub btnNext_Click(ByVal sender As Object, ByVal s As EventArgs)
        Dim success As Boolean = CType(_currentStep, IWizardStep).NextStep()
        If success Then
            If (StepIndex < _wizardSteps.Count - 1) Then
                StepIndex = StepIndex + 1
                LoadWizardStep()
            End If
        End If
    End Sub
 
    ''' <summary>
    ''' Move to the previous step
    ''' </summary>
    Sub btnPrevious_Click(ByVal sender As Object, ByVal e As EventArgs)
        If StepIndex > 0 Then
            StepIndex = StepIndex - 1
            LoadWizardStep()
        End If
    End Sub

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            font:14px Georgia,Serif;
        }
        fieldset
        {
            display:block;
            width:600px;
            padding:20px;
            margin:10px;
        }
    </style>
    <title>Wizard</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:Label
        id="lblStepNumber"
        Runat="server" />

    <fieldset>
    <legend><asp:Literal ID="ltlStep" runat="server" /></legend>
        <asp:PlaceHolder
            id="plhWizardStep"
            Runat="server" />
    </fieldset>

    <asp:Button 
        id="btnPrevious"
        Text="&lt; Previous"
        CausesValidation="false"
        OnClick="btnPrevious_Click" 
        Runat="server" />
    
    <asp:Button
        id="btnNext"
        Text="Next &gt;"
        OnClick="btnNext_Click" 
        Runat="server" />
        
    </div>
    </form>
</body>
</html>
