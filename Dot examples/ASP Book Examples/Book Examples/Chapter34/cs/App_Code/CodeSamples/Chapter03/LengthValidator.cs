using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CodeSamples.Chapter03
{
    /// <summary>
    /// Validates the length of an input field
    /// </summary>
    public class LengthValidator : BaseValidator
    {
        int _maximumLength = 0;

        public int MaximumLength
        {
            get { return _maximumLength; }
            set { _maximumLength = value; }
        }

        protected override bool EvaluateIsValid()
        {
            String value = this.GetControlValidationValue(this.ControlToValidate);
            if (value.Length > _maximumLength)
                return false;
            else
                return true;
        }
    }
}