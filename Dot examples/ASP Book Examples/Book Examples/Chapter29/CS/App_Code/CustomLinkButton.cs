using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace myControls
{
    public class CustomLinkButton : WebControl, IPostBackEventHandler
    {
        public event EventHandler Click;

        private string _Text;

        public string Text
        {
            get { return _Text; }
            set { _Text = value; }
        }

        protected override void AddAttributesToRender(HtmlTextWriter writer)
        {
            string eRef = Page.ClientScript.GetPostBackClientHyperlink(this, String.Empty);
            writer.AddAttribute(HtmlTextWriterAttribute.Href, eRef);
            base.AddAttributesToRender(writer);
        }

        protected override HtmlTextWriterTag TagKey
        {
            get
            {
                return HtmlTextWriterTag.A;
            }
        }

        protected override void RenderContents(HtmlTextWriter writer)
        {
            writer.Write(_Text);
        }


        public void RaisePostBackEvent(string eventArgument)
        {
            if (Click != null)
                Click(this, EventArgs.Empty);
        }
    }
}