using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace myControls
{

    public class ControlStateControl : WebControl
    {

        private string _controlStateText;

        public string ViewStateText
        {
            get
            {
                if (ViewState["ViewStateText"] == null)
                    return String.Empty;
                else
                    return (string)ViewState["ViewStateText"];
            }
            set { ViewState["ViewStateText"] = value; }
        }

        public string ControlStateText
        {
            get { return _controlStateText; }
            set { _controlStateText = value; }
        }

        protected override void OnInit(EventArgs e)
        {
            Page.RegisterRequiresControlState(this);
            base.OnInit(e);
        }

        protected override object SaveControlState()
        {
            return _controlStateText;
        }

        protected override void LoadControlState(object savedState)
        {
            _controlStateText = (string)savedState;
        }

        protected override void RenderContents(HtmlTextWriter writer)
        {
            writer.Write("ViewStateText: " + ViewStateText);
            writer.WriteBreak();
            writer.Write("ControlStateText: " + ControlStateText);
            writer.WriteBreak();
        }

    }
}