using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;

namespace myControls
{
    [DefaultProperty("Title")]
    public class MovieView : WebControl
    {

        private string _title = "Movie Title";
        private string _description = "Movie Description";

        [Category("Movie")]
        [Description("Movie Title")]
        public string Title
        {
            get { return _title; }
            set { _title = value; }
        }

        [Category("Movie")]
        [Description("Movie Description")]
        public string Description
        {
            get { return _description; }
            set { _description = value; }
        }


        protected override void RenderContents(HtmlTextWriter writer)
        {
            writer.RenderBeginTag(HtmlTextWriterTag.H1);
            writer.Write(_title);
            writer.RenderEndTag();

            writer.Write(_description);
        }

        protected override HtmlTextWriterTag TagKey
        {
            get
            {
                return HtmlTextWriterTag.Div;
            }
        }
    }
}