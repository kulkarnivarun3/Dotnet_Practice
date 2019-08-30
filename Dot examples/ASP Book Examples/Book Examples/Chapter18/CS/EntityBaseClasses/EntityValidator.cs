using System;
using System.Web.UI.WebControls;
using System.Web.UI;

namespace Superexpert.Controls
{

    public class EntityValidator : BaseValidator
    {
        public string PropertyName { get; set; }
        public string TypeName { get; set; }

        private string _Text = "Invalid";


        public override string Text
        {
            get
            {
                return _Text;
            }
            set
            {
                _Text = value;
            }
        }


        protected override bool ControlPropertiesValid()
        {
            if (!String.IsNullOrEmpty(TypeName) && String.IsNullOrEmpty(ControlToValidate))
                throw new Exception("When setting TypeName, you must set ControlToValidate");
            if (!String.IsNullOrEmpty(ControlToValidate))
                return base.ControlPropertiesValid();
            return true;
        }


        protected override bool EvaluateIsValid()
        {
            if (!String.IsNullOrEmpty(TypeName))
            {
                string value = this.GetControlValidationValue(this.ControlToValidate);
                return ValidationUtility.SatisfiesType(value, TypeName);
            }
            return true;
        }

        protected override void Render(HtmlTextWriter writer)
        {
            if (IsValid == false)
            {
                base.Render(writer);
            }
        }


        protected override void RenderContents(HtmlTextWriter writer)
        {
            if (String.IsNullOrEmpty(Text))
                writer.Write("Invalid value");
            else
                writer.Write(Text);
        }

    }

}
