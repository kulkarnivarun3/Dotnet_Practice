using System.Web.UI;
using System.Web.UI.WebControls;

namespace myControls
{
    public class DropShadow : WebControl
    {
        private string _Text;

        public string Text
        {
            get { return _Text; }
            set { _Text = value; }
        }

        protected override void RenderContents(HtmlTextWriter writer)
        {
            writer.AddStyleAttribute(HtmlTextWriterStyle.Filter, "dropShadow(color=#AAAAAA,offX=3,offY=3);width:500px");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);
            writer.Write(_Text);
            writer.RenderEndTag();
        }
    }
}