using System;
using System.Collections;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace myControls
{
    [ControlBuilder(typeof(ServerTabsBuilder))]
    [ParseChildren(false)]
    public class ServerTabs : WebControl, IPostBackEventHandler
    {
        public int SelectedTabIndex
        {
            get
            {
                if (ViewState["SelectedTabIndex"] == null)
                    return 0;
                else
                    return (int)ViewState["SelectedTabIndex"];
            }
            set
            {
                ViewState["SelectedTabIndex"] = value;
            }
        }

        protected override void RenderContents(HtmlTextWriter writer)
        {
            for (int i = 0; i < this.Controls.Count; i++)
            {
                ServerTab tab = (ServerTab)this.Controls[i];
                string eRef = Page.ClientScript.GetPostBackClientHyperlink(this, i.ToString());

                if (SelectedTabIndex == i)
                    writer.AddAttribute(HtmlTextWriterAttribute.Class, "tab selectedTab");
                else
                    writer.AddAttribute(HtmlTextWriterAttribute.Class, "tab");
                writer.RenderBeginTag(HtmlTextWriterTag.Div);
                writer.AddAttribute(HtmlTextWriterAttribute.Href, eRef);
                writer.RenderBeginTag(HtmlTextWriterTag.A);
                writer.Write(tab.Text);
                writer.RenderEndTag(); // A
                writer.RenderEndTag(); // Tab DIV
            }
            writer.Write("<br style='clear:both' />");

            writer.AddAttribute(HtmlTextWriterAttribute.Class, "tabContents");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);
            this.Controls[SelectedTabIndex].RenderControl(writer);
            writer.RenderEndTag(); // Tab Contents DIV
        }

        protected override void AddParsedSubObject(object obj)
        {
            if (obj is ServerTab)
                base.AddParsedSubObject(obj);
        }

        protected override HtmlTextWriterTag TagKey
        {
            get
            {
                return HtmlTextWriterTag.Div;
            }
        }

        public void RaisePostBackEvent(string eventArgument)
        {
            SelectedTabIndex = Int32.Parse(eventArgument);
        }
    }

    public class ServerTabsBuilder : ControlBuilder
    {
        public override Type GetChildControlType(string tagName, IDictionary attribs)
        {
            if (String.Compare(tagName, "tab", true) == 0)
                return typeof(ServerTab);
            else
                return null;
        }
    }

    public class ServerTab : Control
    {
        private string _Text;

        public string Text
        {
            get { return _Text; }
            set { _Text = value; }
        }
    }
}