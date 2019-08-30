using System;
using System.Collections;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;

namespace myControls
{
    [ParseChildren(true, "Items")]
    public class ItemRotator : CompositeControl
    {
        private ArrayList _items = new ArrayList();

        [Browsable(false)]
        public ArrayList Items
        {
            get { return _items; }
        }

        protected override void CreateChildControls()
        {
            Random rnd = new Random();
            int index = rnd.Next(_items.Count);
            Control item = (Control)_items[index];
            this.Controls.Add(item);
        }
    }

    public class Item : Control
    {

    }
}