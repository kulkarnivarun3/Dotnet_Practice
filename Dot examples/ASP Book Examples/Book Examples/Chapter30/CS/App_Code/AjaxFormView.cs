using System;
using System.Collections;
using System.Collections.Specialized;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;

namespace AspNetUnleashed
{
    public class AjaxFormView : CompositeDataBoundControl, ICallbackEventHandler
    {
        const string scriptPath = "~/ClientScripts/AjaxFormView.js";

        private IBindableTemplate _insertItemTemplate;
        private IBindableTemplate _editItemTemplate;
        private AjaxFormViewItem _item;
        private AjaxFormViewMode _defaultMode = AjaxFormViewMode.Edit;
        private string _clientCallbackResult;
        private string[] _dataKeyNames;
        private DataKey _dataKey;
        private OrderedDictionary _keyTable;
        private string _onClientItemInserted = "AjaxFormView_ItemInserted";
        private string _onClientItemUpdated = "AjaxFormView_ItemUpdated";


        /// <summary>
        /// Represents the template for inserting new items
        /// </summary>
        [TemplateContainer(typeof(AjaxFormViewItem), BindingDirection.TwoWay)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        public IBindableTemplate InsertItemTemplate
        {
            get { return _insertItemTemplate; }
            set { _insertItemTemplate = value; }
        }

        /// <summary>
        /// Represents the template for editing items
        /// </summary>
        [TemplateContainer(typeof(AjaxFormViewItem), BindingDirection.TwoWay)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        public IBindableTemplate EditItemTemplate
        {
            get { return _editItemTemplate; }
            set { _editItemTemplate = value; }
        }

        /// <summary>
        /// Represents the primary keys from the database. 
        /// </summary>
        [TypeConverter(typeof(StringArrayConverter))]
        public string[] DataKeyNames
        {
            get { return _dataKeyNames; }
            set { _dataKeyNames = value; }
        }

        /// <summary>
        /// Represents the current DataKey. This
        /// is need for updating a record
        /// </summary>
        public DataKey DataKey
        {
            get
            {
                if (_dataKey == null)
                {
                    _dataKey = new DataKey(_keyTable);
                }
                return _dataKey;
            }
        }

        /// <summary>
        /// Enables you to place the control in
        /// either Insert or Edit mode
        /// </summary>
        public AjaxFormViewMode DefaultMode
        {
            get { return _defaultMode; }
            set { _defaultMode = value; }
        }

        /// <summary>
        /// Enables you to execute a custom
        /// Javascript when an item is inserted
        /// </summary>
        public string OnClientItemInserted
        {
            get { return _onClientItemInserted; }
            set { _onClientItemInserted = value; }
        }


        /// <summary>
        /// Enables you to execute a custom
        /// Javascript when an item is updated
        /// </summary>
        public string OnClientItemUpdated
        {
            get { return _onClientItemUpdated; }
            set { _onClientItemUpdated = value; }
        }


        /// <summary>
        /// Register that we need Control State. The
        /// DataKey is stored in Control State.
        /// </summary>
        protected override void OnInit(EventArgs e)
        {
            Page.RegisterRequiresControlState(this);
            base.OnInit(e);
        }

        /// <summary>
        /// Register the JavaScript AJAX script
        /// </summary>
        protected override void OnPreRender(EventArgs e)
        {
            Page.ClientScript.RegisterClientScriptInclude("AjaxFormView", Page.ResolveUrl(scriptPath));
            base.OnPreRender(e);
        }

        /// <summary>
        /// Create either the InsertItemTemplate or the EditItemTemplate
        /// </summary>
        protected override int CreateChildControls(IEnumerable dataSource, bool dataBinding)
        {
            if (_defaultMode == AjaxFormViewMode.Edit)
            {
                _item = GetEditItem(dataSource, dataBinding);
                _editItemTemplate.InstantiateIn(_item);
            }
            else
            {
                _item = new AjaxFormViewItem();
                _insertItemTemplate.InstantiateIn(_item);
            }
            Controls.Add(_item);
            DataBind(false);

            return 1;
        }

        /// <summary>
        /// Get the first item from the data source and grab
        /// the data keys
        /// </summary>
        private AjaxFormViewItem GetEditItem(IEnumerable dataSource, bool dataBinding)
        {
            AjaxFormViewItem editItem = null;
            if (dataSource != null)
            {
                IEnumerator en = dataSource.GetEnumerator();
                if (en.MoveNext())
                {
                    editItem = new AjaxFormViewItem(en.Current);
                    if (_dataKeyNames != null)
                    {
                        if (dataBinding)
                        {
                            _keyTable = new OrderedDictionary();
                            foreach (string key in _dataKeyNames)
                            {
                                _keyTable.Add(key, DataBinder.Eval(en.Current, key));
                            }
                        }
                    }
                }
            }
            return editItem;
        }

        /// <summary>
        /// Render the Insert or Edit button at the bottom
        /// of the normal control content
        /// </summary>
        protected override void RenderContents(HtmlTextWriter writer)
        {
            // Render the template
            base.RenderContents(writer);

            // Render either the Edit or Insert button
            writer.RenderBeginTag(HtmlTextWriterTag.Div);
            if (_defaultMode == AjaxFormViewMode.Edit)
                RenderUpdateButton(writer);
            else
                RenderInsertButton(writer);
            writer.RenderEndTag();
        }

        /// <summary>
        /// Render the Update button with the AJAX onclick handler
        /// </summary>
        private void RenderUpdateButton(HtmlTextWriter writer)
        {
            string eRef = Page.ClientScript.GetCallbackEventReference(this, "'update'", _onClientItemUpdated, "'" + this.ClientID + "'", "AjaxFormView_Error", true);
            eRef = "__theFormPostData='';WebForm_InitCallback();" + eRef + ";return false";
            writer.AddAttribute(HtmlTextWriterAttribute.Onclick, eRef);
            writer.RenderBeginTag(HtmlTextWriterTag.Button);
            writer.Write("Update");
            writer.RenderEndTag();
        }


        /// <summary>
        /// Render the Insert button with the AJAX onclick handler
        /// </summary>
        private void RenderInsertButton(HtmlTextWriter writer)
        {
            string eRef = Page.ClientScript.GetCallbackEventReference(this, "'insert'", _onClientItemInserted, "'" + this.ClientID + "'", "AjaxFormView_Error", false);
            eRef = "__theFormPostData='';WebForm_InitCallback();" + eRef + ";return false";
            writer.AddAttribute(HtmlTextWriterAttribute.Onclick, eRef);
            writer.RenderBeginTag(HtmlTextWriterTag.Button);
            writer.Write("Insert");
            writer.RenderEndTag();
        }

        /// <summary>
        /// Render this control in a DIV
        /// </summary>
        protected override HtmlTextWriterTag TagKey
        {
            get
            {
                return HtmlTextWriterTag.Div;
            }
        }

        /// <summary>
        /// Called on the server by AJAX on the client
        /// </summary>
        public void RaiseCallbackEvent(string eventArgument)
        {
            switch (eventArgument)
            {
                case "update":
                    HandleUpdate();
                    break;
                case "insert":
                    HandleInsert();
                    break;
            }
        }

        /// <summary>
        /// Perform database update by executing DataSource Update method
        /// </summary>
        private void HandleUpdate()
        {
            IOrderedDictionary values = _editItemTemplate.ExtractValues(_item);
            DataSourceView dataSource = (DataSourceView)this.GetData();
            dataSource.Update(DataKey.Values, values, null, new DataSourceViewOperationCallback(DataCallback));
        }

        /// <summary>
        /// Perform database insert by executing DataSource Insert method
        /// </summary>
        private void HandleInsert()
        {
            IOrderedDictionary values = _insertItemTemplate.ExtractValues(_item);
            DataSourceView dataSource = (DataSourceView)this.GetData();
            dataSource.Insert(values, new DataSourceViewOperationCallback(DataCallback));
        }

        /// <summary>
        /// Called after asynchronous database command completes
        /// </summary>
        private bool DataCallback(int affectedRecords, Exception ex)
        {
            if (ex != null)
                _clientCallbackResult = ex.Message;
            return true;
        }

        /// <summary>
        /// Return AJAX callback result to client
        /// </summary>
        public string GetCallbackResult()
        {
            return _clientCallbackResult;
        }

        /// <summary>
        /// Save data keys in Control State
        /// </summary>
        protected override object SaveControlState()
        {
            return _keyTable;
        }

        /// <summary>
        /// Load data keys from Control State
        /// </summary>
        protected override void LoadControlState(object savedState)
        {
            _keyTable = (OrderedDictionary)savedState;
        }

    }

    /// <summary>
    /// Represents an AjaxFormView data item. Also acts as a container
    /// for an EditItemTemplate or InsertItemTemplate
    /// </summary>
    public class AjaxFormViewItem : WebControl, IDataItemContainer
    {
        private object _dataItem;

        public object DataItem
        {
            get { return _dataItem; }
        }

        public int DataItemIndex
        {
            get { return 0; }
        }

        public int DisplayIndex
        {
            get { return 0; }
        }

        public AjaxFormViewItem(object dataItem)
        {
            _dataItem = dataItem;
        }

        public AjaxFormViewItem()
        {
        }
    }


    public enum AjaxFormViewMode
    {
        Edit = 0,
        Insert = 1
    }


}