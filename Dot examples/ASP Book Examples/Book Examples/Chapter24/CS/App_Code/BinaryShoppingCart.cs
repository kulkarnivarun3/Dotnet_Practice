using System;
using System.Collections.Generic;
using System.Web.Profile;

namespace AspNetUnleashed
{
    [Serializable]
    public class BinaryShoppingCart
    {
        private List<BinaryCartItem> _items = new List<BinaryCartItem>();

        public List<BinaryCartItem> Items
        {
            get { return _items; }
        }
    }

    [Serializable]
    public class BinaryCartItem
    {
        private string _name;
        private decimal _price;
        private string _description;

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

        public string Description
        {
            get { return _description; }
            set { _description = value; }
        }

        public BinaryCartItem() { }

        public BinaryCartItem(string name, decimal price, string description)
        {
            _name = name;
            _price = price;
            _description = description;
        }
    }
}