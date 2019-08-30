using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace myControls
{
    public class AdvancedCheckBox : WebControl
    {
        private string _Text;
        private string _PostBackUrl;

        public string Text
        {
            get { return _Text; }
            set { _Text = value; }
        }

        public string PostBackUrl
        {
            get { return _PostBackUrl; }
            set { _PostBackUrl = value; }
        }

        protected override void AddAttributesToRender(HtmlTextWriter writer)
        {
            PostBackOptions options = new PostBackOptions(this);
            options.ActionUrl = _PostBackUrl;

            string eRef = Page.ClientScript.GetPostBackEventReference(options);

            writer.AddAttribute(HtmlTextWriterAttribute.Onclick, eRef);
            writer.AddAttribute(HtmlTextWriterAttribute.Name, this.UniqueID);
            writer.AddAttribute(HtmlTextWriterAttribute.Type, "checkbox");


            base.AddAttributesToRender(writer);
        }

        protected override void RenderContents(HtmlTextWriter writer)
        {
            if (!String.IsNullOrEmpty(_Text))
            {
                writer.AddAttribute(HtmlTextWriterAttribute.For, this.ClientID);
                writer.RenderBeginTag(HtmlTextWriterTag.Label);
                writer.Write(_Text);
                writer.RenderEndTag();
            }
        }

        protected override HtmlTextWriterTag TagKey
        {
            get
            {
                return HtmlTextWriterTag.Input;
            }
        }
    }
}