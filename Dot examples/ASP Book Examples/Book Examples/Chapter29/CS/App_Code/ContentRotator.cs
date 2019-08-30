using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace myControls
{
    [ParseChildren(false)]
    public class ContentRotator : WebControl
    {

        protected override void AddParsedSubObject(object obj)
        {
            if (obj is Content)
                base.AddParsedSubObject(obj);
        }

        protected override void RenderContents(HtmlTextWriter writer)
        {
            Random rnd = new Random();
            int index = rnd.Next(this.Controls.Count);
            this.Controls[index].RenderControl(writer);
        }
    }

    public class Content : Control
    {


    }
}