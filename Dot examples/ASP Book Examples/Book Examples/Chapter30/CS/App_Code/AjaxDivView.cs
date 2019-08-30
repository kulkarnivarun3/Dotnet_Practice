using System;
using System.Text;
using System.IO;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AspNetUnleashed
{
    public class AjaxDivView : CompositeDataBoundControl, ICallbackEventHandler
    {
        private ITemplate _itemTemplate;

        /// <summary>
        /// The ItemTemplate is used to format each item
        /// from the data source
        /// </summary>
        [TemplateContainer(typeof(DivViewItem))]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        public ITemplate ItemTemplate
        {
            get { return _itemTemplate; }
            set { _itemTemplate = value; }
        }

        /// <summary>
        /// Register JavaScripts
        /// </summary>
        protected override void OnPreRender(EventArgs e)
        {
            // Register JavaScript library
            Page.ClientScript.RegisterClientScriptInclude("AjaxDivView", Page.ResolveUrl("~/ClientScripts/AjaxDivView.js"));

            // Register Refresh function
            string eRef = Page.ClientScript.GetCallbackEventReference(this, null, "AjaxDivView_Result", "'" + this.ClientID + "'", "AjaxDivView_Error", false);
            string refreshFunc = "function AjaxDivView_Refresh() {" + eRef + "}";
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), this.UniqueID, refreshFunc, true);

            base.OnPreRender(e);
        }



        /// <summary>
        /// Iterate through the data items and instantiate each data
        /// item in a template
        /// </summary>
        protected override int CreateChildControls(IEnumerable dataSource, bool dataBinding)
        {
            int counter = 0;
            foreach (object dataItem in dataSource)
            {
                DivViewItem contentItem = new DivViewItem(dataItem, counter);
                _itemTemplate.InstantiateIn(contentItem);
                Controls.Add(contentItem);
                counter++;
            }
            DataBind(false);
            return counter;
        }

        /// <summary>
        /// Render this control's contents in a DIV tag
        /// </summary>
        protected override HtmlTextWriterTag TagKey
        {
            get
            {
                return HtmlTextWriterTag.Div;
            }
        }

        /// <summary>
        /// Whenever I get called through AJAX,
        /// rebind my data
        /// </summary>
        public void RaiseCallbackEvent(string eventArgument)
        {
            this.DataBind();
        }

        /// <summary>
        /// Render my contents to a string
        /// and send the result back to the client
        /// </summary>
        public string GetCallbackResult()
        {
            StringBuilder builder = new StringBuilder();
            StringWriter sWriter = new StringWriter(builder);
            HtmlTextWriter hWriter = new HtmlTextWriter(sWriter);
            this.RenderContents(hWriter);
            return builder.ToString();
        }

    }


    public class AjaxDivViewItem : WebControl, IDataItemContainer
    {
        private object _dataItem;
        private int _index;


        public object DataItem
        {
            get { return _dataItem; }
        }

        public int DataItemIndex
        {
            get { return _index; }
        }

        public int DisplayIndex
        {
            get { return _index; }
        }

        protected override HtmlTextWriterTag TagKey
        {
            get
            {
                return HtmlTextWriterTag.Div;
            }
        }

        public AjaxDivViewItem(object dataItem, int index)
        {
            _dataItem = dataItem;
            _index = index;
        }

    }
}