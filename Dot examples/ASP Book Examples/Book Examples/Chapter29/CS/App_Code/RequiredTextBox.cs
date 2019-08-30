using System;
using System.Web.UI.WebControls;

namespace myControls
{
    public class RequiredTextBox : CompositeControl
    {
        private TextBox input;
        private RequiredFieldValidator validator;

        public string Text
        {
            get
            {
                EnsureChildControls();
                return input.Text;
            }
            set
            {
                EnsureChildControls();
                input.Text = value;
            }
        }

        protected override void CreateChildControls()
        {
            input = new TextBox();
            input.ID = "input";
            this.Controls.Add(input);

            validator = new RequiredFieldValidator();
            validator.ID = "valInput";
            validator.ControlToValidate = input.ID;
            validator.ErrorMessage = "(Required)";
            validator.Display = ValidatorDisplay.Dynamic;
            this.Controls.Add(validator);
        }
    }
}