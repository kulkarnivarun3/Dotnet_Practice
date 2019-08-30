using System;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AspNetUnleashed
{
    public class DivView : CompositeDataBoundControl
    {
        private ITemplate _itemTemplate;

        [TemplateContainer(typeof(DivViewItem))]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        public ITemplate ItemTemplate
        {
            get { return _itemTemplate; }
            set { _itemTemplate = value; }
        }

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

        protected override HtmlTextWriterTag TagKey
        {
            get
            {
                return HtmlTextWriterTag.Div;
            }
        }
    }


    public class DivViewItem : WebControl, IDataItemContainer
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

        public DivViewItem(object dataItem, int index)
        {
            _dataItem = dataItem;
            _index = index;
        }

    }
}