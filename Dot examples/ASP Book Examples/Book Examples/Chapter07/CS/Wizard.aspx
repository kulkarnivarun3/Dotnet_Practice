<%@ Page Language="C#" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
    
    private List<String> _wizardSteps = new List<String>();
    private Control _currentStep;

    /// <summary>
    /// The current step in the Wizard
    /// </summary>
    public int StepIndex
    {
        get
        {
            if (ViewState["StepIndex"] == null)
                return 0;
            else
                return (int)ViewState["StepIndex"];
        }
        set
        {
            ViewState["StepIndex"] = value;
        }
    }

    /// <summary>
    /// Load the list of wizard steps and load 
    /// current step
    /// </summary>
    void Page_Load()
    {
        _wizardSteps.Add("~/WizardSteps/Step1.ascx");
        _wizardSteps.Add("~/WizardSteps/Step2.ascx");
        _wizardSteps.Add("~/WizardSteps/Step3.ascx");

        LoadWizardStep();
    }

    /// <summary>
    /// Load the current wizard step
    /// </summary>
    private void LoadWizardStep()
    {
        _currentStep = Page.LoadControl(_wizardSteps[StepIndex]);
        _currentStep.ID = "ctlWizardStep";
        plhWizardStep.Controls.Clear();
        plhWizardStep.Controls.Add(_currentStep);
        ((IWizardStep)_currentStep).LoadStep();
        ltlStep.Text = String.Format("Step {0} of {1}", StepIndex + 1, _wizardSteps.Count);
    }

    /// <summary>
    /// Disable the Previous and Next
    /// buttons when appropriate
    /// </summary>
    void Page_PreRender()
    {
        btnPrevious.Enabled = StepIndex > 0;
        btnNext.Enabled = StepIndex < _wizardSteps.Count - 1;
    }
    
    /// <summary>
    /// Execute the step's NextStep() method
    /// and move to the next step
    /// </summary>
    protected void btnNext_Click(object sender, EventArgs e)
    {
        bool success = ((IWizardStep)_currentStep).NextStep();
        if (success)
        {
            if (StepIndex < _wizardSteps.Count - 1)
            {
                StepIndex++;
                LoadWizardStep();
            }
        }
    }

    /// <summary>
    /// Move to the previous step
    /// </summary>
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (StepIndex > 0)
        {
            StepIndex--;
            LoadWizardStep();
        }
    }
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
