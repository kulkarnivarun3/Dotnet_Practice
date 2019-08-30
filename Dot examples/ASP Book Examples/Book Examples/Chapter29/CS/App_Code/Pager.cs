using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace myControls
{
    public class Pager : WebControl, IPostBackEventHandler
    {
        string _controlToPage;

        public string ControlToPage
        {
            get { return _controlToPage; }
            set { _controlToPage = value; }
        }

        protected override void RenderContents(HtmlTextWriter writer)
        {
            GridView grid = GetControlToPage();

            for (int i = 0; i < grid.PageCount; i++)
            {
                string eRef = Page.ClientScript.GetPostBackClientHyperlink(this, i.ToString());
                writer.Write("[");
                if (i == grid.PageIndex)
                    writer.AddStyleAttribute(HtmlTextWriterStyle.FontWeight, "bold");
                writer.AddAttribute(HtmlTextWriterAttribute.Href, eRef);
                writer.RenderBeginTag(HtmlTextWriterTag.A);
                writer.Write("{0}", i + 1);
                writer.RenderEndTag();
                writer.Write("] ");
            }
        }

        private GridView GetControlToPage()
        {
            if (String.IsNullOrEmpty(_controlToPage))
                throw new Exception("Must set ControlToPage property");
            return (GridView)Page.FindControl(_controlToPage);
        }

        public void RaisePostBackEvent(string eventArgument)
        {
            GridView grid = GetControlToPage();
            grid.PageIndex = Int32.Parse(eventArgument);
        }
    }
}