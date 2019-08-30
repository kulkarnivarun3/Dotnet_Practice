using System.Web.UI;

namespace myControls
{
    public class FullyRenderedControl : Control
    {
        private string _Text;

        public string Text
        {
            get { return _Text; }
            set { _Text = value; }
        }

        protected override void Render(HtmlTextWriter writer)
        {
            writer.Write(_Text);
        }
    }
}