using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace myControls
{
    /// <summary>
    /// Enables you to perform custom validation on both the client and server
    /// </summary>
    public class AjaxValidator : BaseValidator, ICallbackEventHandler
    {
        public event ServerValidateEventHandler ServerValidate;

        private string _controlToValidateValue;

        protected override void OnPreRender(EventArgs e)
        {
            string eventRef = Page.ClientScript.GetCallbackEventReference(this, "", "", "");

            // Register include file
            string includeScript = Page.ResolveClientUrl("~/ClientScripts/AjaxValidator.js");
            Page.ClientScript.RegisterClientScriptInclude("AjaxValidator", includeScript);

            // Register startup script
            string startupScript = String.Format("document.getElementById('{0}').evaluationfunction = 'AjaxValidatorEvaluateIsValid';", this.ClientID);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "AjaxValidator", startupScript, true);

            base.OnPreRender(e);
        }

        /// <summary>
        /// Only do the AJAX on browsers that support it
        /// </summary>
        protected override bool DetermineRenderUplevel()
        {
            return Context.Request.Browser.SupportsCallback;
        }

        /// <summary>
        /// Server method called by client AJAX call
        /// </summary>
        public string GetCallbackResult()
        {
            return ExecuteValidationFunction(_controlToValidateValue).ToString();
        }

        /// <summary>
        /// Return callback result to client
        /// </summary>
        public void RaiseCallbackEvent(string eventArgument)
        {
            _controlToValidateValue = eventArgument;
        }

        /// <summary>
        /// Server-side method for validation
        /// </summary>
        protected override bool EvaluateIsValid()
        {
            string controlToValidateValue = this.GetControlValidationValue(this.ControlToValidate);
            return ExecuteValidationFunction(controlToValidateValue);
        }

        /// <summary>
        /// Performs the validation for both server and client
        /// </summary>
        private bool ExecuteValidationFunction(string controlToValidateValue)
        {
            ServerValidateEventArgs args = new ServerValidateEventArgs(controlToValidateValue, this.IsValid);
            ServerValidate(this, args);
            return args.IsValid;
        }

    }
}
