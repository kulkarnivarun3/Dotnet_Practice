using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace myControls
{
    public class CustomTextBox : WebControl, IPostBackDataHandler
    {
        public event EventHandler TextChanged;

        public string Text
        {
            get
            {
                if (ViewState["Text"] == null)
                    return String.Empty;
                else
                    return (string)ViewState["Text"];
            }

            set { ViewState["Text"] = value; }
        }

        protected override void AddAttributesToRender(HtmlTextWriter writer)
        {
            writer.AddAttribute(HtmlTextWriterAttribute.Type, "text");
            writer.AddAttribute(HtmlTextWriterAttribute.Value, Text);
            writer.AddAttribute(HtmlTextWriterAttribute.Name, this.UniqueID);
            base.AddAttributesToRender(writer);
        }

        protected override HtmlTextWriterTag TagKey
        {
            get
            {
                return HtmlTextWriterTag.Input;
            }
        }

        public bool LoadPostData(string postDataKey, System.Collections.Specialized.NameValueCollection postCollection)
        {
            if (postCollection[postDataKey] != Text)
            {
                Text = postCollection[postDataKey];
                return true;
            }
            return false;
        }

        public void RaisePostDataChangedEvent()
        {
            if (TextChanged != null)
                TextChanged(this, EventArgs.Empty);
        }
    }
}