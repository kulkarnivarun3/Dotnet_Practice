using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyControls
{

    public class PagePropertyParameter : Parameter
    {
        private string _propertyName;

        protected override object Evaluate(HttpContext context, Control control)
        {
            return DataBinder.Eval(control.Page, PropertyName);
        }

        public string PropertyName
        {
            get { return _propertyName; }
            set { _propertyName = value; }
        }

    }
}