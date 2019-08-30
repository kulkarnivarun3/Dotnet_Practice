using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace myControls
{
    public class ViewStateControl : WebControl
    {
        private string _text;

        public string Text
        {
            get { return _text; }
            set { _text = value; }
        }

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

        protected override void RenderContents(HtmlTextWriter writer)
        {
            writer.Write("Text: " + Text);
            writer.WriteBreak();
            writer.Write("ViewStateText: " + ViewStateText);
            writer.WriteBreak();
        }

    }
}