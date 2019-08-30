using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace MyControls
{

    /// <summary>
    /// Enables you to select mulitple list items
    /// from two list boxes
    /// </summary>
    [ValidationProperty("SelectedItem")]
    public class MultiSelectList : ListControl, IPostBackDataHandler
    {
        private int _rows = 5;
        private Unit _UnSelectedWidth = Unit.Parse("300px");
        private Unit _SelectedWidth = Unit.Parse("300px");


        /// <summary>
        /// This control is contained in a div
        /// tag
        /// </summary>
        protected override HtmlTextWriterTag TagKey
        {
            get { return HtmlTextWriterTag.Div; }
        }

        protected override void AddAttributesToRender(HtmlTextWriter writer)
        {
            writer.AddStyleAttribute("position", "relative");
            base.AddAttributesToRender(writer);
        }

        /// <summary>
        /// The number of rows of list items to display
        /// </summary>
        public int Rows
        {
            get { return _rows; }
            set { _rows = value; }
        }


        /// <summary>
        /// Name passed to client-side script
        /// </summary>
        private string BaseName
        {
            get { return ClientID + ClientIDSeparator; }
        }

        /// <summary>
        /// Name of unselected items list box
        /// </summary>
        private string UnselectedListName
        {
            get { return BaseName + "unselected"; }
        }

        /// <summary>
        /// Name of selected items list box
        /// </summary>
        private string SelectedListName
        {
            get { return BaseName + "selected"; }
        }

        /// <summary>
        /// Name of hidden input field
        /// </summary>
        private string HiddenName
        {
            get { return BaseName + "hidden"; }
        }

        /// <summary>
        /// Register client scripts
        /// </summary>
        protected override void OnPreRender(EventArgs e)
        {
            Page.RegisterRequiresPostBack(this);

            // Register hidden field
            Page.ClientScript.RegisterHiddenField(HiddenName, String.Empty);

            // Register Include File
            if (!Page.ClientScript.IsClientScriptIncludeRegistered("MultiSelectList"))
                Page.ClientScript.RegisterClientScriptInclude("MultiSelectList", Page.ResolveUrl("~/ClientScripts/MultiSelectList.js"));

            // Register submit script
            string submitScript = String.Format("multiSelectList_submit('{0}')", BaseName);
            Page.ClientScript.RegisterOnSubmitStatement(this.GetType(), this.ClientID, submitScript);

            base.OnPreRender(e);
        }

        /// <summary>
        /// Render list boxes and buttons
        /// </summary>
        protected override void RenderContents(HtmlTextWriter writer)
        {

            // Render Unselected
            RenderUnselected(writer);

            // Render Buttons
            RenderButtons(writer);

            // Render Selected
            RenderSelected(writer);

            // Render clear break
            writer.AddStyleAttribute("clear", "both");
            writer.RenderBeginTag(HtmlTextWriterTag.Br);
            writer.RenderEndTag();
        }

        /// <summary>
        /// Render the buttons
        /// </summary>
        private void RenderButtons(HtmlTextWriter writer)
        {
            writer.AddStyleAttribute("float", "left");
            writer.AddStyleAttribute(HtmlTextWriterStyle.Padding, "10px");
            writer.AddStyleAttribute(HtmlTextWriterStyle.TextAlign, "center");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);

            string addScript = String.Format("return multiSelectList_add('{0}');", BaseName);
            writer.AddAttribute(HtmlTextWriterAttribute.Onclick, addScript);
            writer.AddAttribute(HtmlTextWriterAttribute.Title, "Add Item");
            writer.RenderBeginTag(HtmlTextWriterTag.Button);
            writer.Write("--&gt;");
            writer.RenderEndTag();
            writer.WriteBreak();
            string removeScript = String.Format("return multiSelectList_remove('{0}');", BaseName);
            writer.AddAttribute(HtmlTextWriterAttribute.Onclick, removeScript);
            writer.AddAttribute(HtmlTextWriterAttribute.Title, "Remove Item");
            writer.RenderBeginTag(HtmlTextWriterTag.Button);
            writer.Write("&lt;--");
            writer.RenderEndTag();

            writer.RenderEndTag();
        }

        /// <summary>
        /// Render unselected list box
        /// </summary>
        private void RenderUnselected(HtmlTextWriter writer)
        {
            writer.AddStyleAttribute("float", "left");
            writer.AddAttribute(HtmlTextWriterAttribute.Size, _rows.ToString());
            writer.AddStyleAttribute(HtmlTextWriterStyle.Width, _UnSelectedWidth.ToString());
            writer.AddAttribute(HtmlTextWriterAttribute.Id, UnselectedListName);
            writer.AddAttribute(HtmlTextWriterAttribute.Name, UnselectedListName);
            writer.AddAttribute(HtmlTextWriterAttribute.Multiple, "true");
            writer.RenderBeginTag(HtmlTextWriterTag.Select);
            foreach (ListItem item in Items)
                if (!item.Selected)
                    RenderListItem(writer, item);
            writer.RenderEndTag();
            //writer.RenderEndTag();
        }

        /// <summary>
        /// Render selected list items
        /// </summary>
        private void RenderSelected(HtmlTextWriter writer)
        {
            writer.AddStyleAttribute("float", "left");
            writer.AddAttribute(HtmlTextWriterAttribute.Size, _rows.ToString());
            writer.AddStyleAttribute(HtmlTextWriterStyle.Width, _SelectedWidth.ToString());
            writer.AddAttribute(HtmlTextWriterAttribute.Id, SelectedListName);
            writer.AddAttribute(HtmlTextWriterAttribute.Name, SelectedListName);
            writer.AddAttribute(HtmlTextWriterAttribute.Multiple, "true");
            writer.RenderBeginTag(HtmlTextWriterTag.Select);
            foreach (ListItem item in Items)
                if (item.Selected)
                    RenderListItem(writer, item);
            writer.RenderEndTag();
            //writer.RenderEndTag();
        }

        /// <summary>
        /// Render a list item
        /// </summary>
        private void RenderListItem(HtmlTextWriter writer, ListItem item)
        {
            writer.AddAttribute(HtmlTextWriterAttribute.Value, item.Value);
            writer.RenderBeginTag(HtmlTextWriterTag.Option);
            writer.Write(item.Text);
            writer.RenderEndTag();
        }

        /// <summary>
        /// Process postback data
        /// </summary>
        public bool LoadPostData(string postDataKey, System.Collections.Specialized.NameValueCollection postCollection)
        {
            EnsureDataBound();
            ClearSelection();

            string values = postCollection[HiddenName];
            if (values != String.Empty)
            {
                string[] splitValues = values.Split(',');
                foreach (string value in splitValues)
                {
                    Items.FindByValue(value).Selected = true;
                }
            }
            return false;
        }

        /// <summary>
        /// Required by the IPostBackDataHandler interface
        /// </summary>
        public void RaisePostDataChangedEvent()
        {
        }


    }
}