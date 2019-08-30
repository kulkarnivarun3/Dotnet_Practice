using System.Web.UI;
using System.Web.UI.WebControls;

namespace myControls
{
    public class FullyRenderedWebControl : WebControl
    {
        private string _Text;

        public string Text
        {
            get { return _Text; }
            set { _Text = value; }
        }

        protected override void RenderContents(HtmlTextWriter writer)
        {
            writer.Write(_Text);
        }
    }
}