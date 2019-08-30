using System;
using System.Collections.Generic;
using System.Web.Profile;

namespace AspNetUnleashed
{
    public class ShoppingCartHasChanged
    {
        private bool _hasChanged = false;
        private List<CartItem> _items = new List<CartItem>();

        public bool HasChanged
        {
            get { return _hasChanged; }
            set { _hasChanged = value; }
        }

        public List<CartItem> Items
        {
            get { return _items; }
        }
    }
}