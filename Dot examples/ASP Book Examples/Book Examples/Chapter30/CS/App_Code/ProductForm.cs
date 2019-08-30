using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;
using System.Collections.Specialized;

namespace myControls
{

    public class ProductForm : CompositeControl
    {
        public event EventHandler ProductUpdated;

        private IBindableTemplate _editItemTemplate;
        private ProductFormItem _item;
        private IOrderedDictionary _results;

        public IOrderedDictionary Results
        {
            get { return _results; }
        }

        public string Name
        {
            get
            {
                EnsureChildControls();
                return _item.Name;
            }
            set
            {
                EnsureChildControls();
                _item.Name = value;
            }
        }

        public decimal Price
        {
            get
            {
                EnsureChildControls();
                return _item.Price;
            }
            set
            {
                EnsureChildControls();
                _item.Price = value;
            }
        }

        [TemplateContainer(typeof(ProductFormItem), BindingDirection.TwoWay)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        public IBindableTemplate EditItemTemplate
        {
            get { return _editItemTemplate; }
            set { _editItemTemplate = value; }
        }

        protected override void CreateChildControls()
        {
            _item = new ProductFormItem();
            _editItemTemplate.InstantiateIn(_item);
            Controls.Add(_item);
        }

        protected override bool OnBubbleEvent(object source, EventArgs args)
        {
            _results = _editItemTemplate.ExtractValues(_item);
            if (ProductUpdated != null)
                ProductUpdated(this, EventArgs.Empty);
            return true;
        }
    }

    public class ProductFormItem : WebControl, IDataItemContainer
    {
        private string _name;
        private decimal _price;

        public string Name
        {
            get { return _name; }
            set { _name = value; }
        }

        public decimal Price
        {
            get { return _price; }
            set { _price = value; }
        }

        public object DataItem
        {
            get { return this; }
        }

        public int DataItemIndex
        {
            get { return 0; }
        }

        public int DisplayIndex
        {
            get { return 0; }
        }

    }
}
