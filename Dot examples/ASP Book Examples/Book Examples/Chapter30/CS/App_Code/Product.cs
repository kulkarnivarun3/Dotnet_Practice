using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace myControls
{
    public class Product : CompositeControl
    {
        private ITemplate _itemTemplate;
        private ProductItem _item;

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

        public Decimal Price
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

        [TemplateContainer(typeof(ProductItem))]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        public ITemplate ItemTemplate
        {
            get { return _itemTemplate; }
            set { _itemTemplate = value; }
        }

        protected override void CreateChildControls()
        {
            _item = new ProductItem();
            _itemTemplate.InstantiateIn(_item);
            Controls.Add(_item);
        }
    }

    public class ProductItem : WebControl, IDataItemContainer
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
            get
            {
                return this;
            }
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