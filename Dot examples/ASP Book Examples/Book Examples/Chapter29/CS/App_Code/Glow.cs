using System.Web.UI;
using System.Web.UI.WebControls;

namespace myControls
{
    public class Glow : WebControl
    {
        private string _Text;

        public string Text
        {
            get { return _Text; }
            set { _Text = value; }
        }

        protected override HtmlTextWriterTag TagKey
        {
            get
            {
                return HtmlTextWriterTag.Div;
            }
        }

        protected override void AddAttributesToRender(HtmlTextWriter writer)
        {
            writer.AddStyleAttribute(HtmlTextWriterStyle.Filter, "glow(Color=#ffd700,Strength=10)");
            base.AddAttributesToRender(writer);
        }

        protected override void RenderContents(HtmlTextWriter writer)
        {
            writer.Write(_Text);
        }

        public Glow()
        {
            this.Width = Unit.Parse("500px");
        }

    }
}