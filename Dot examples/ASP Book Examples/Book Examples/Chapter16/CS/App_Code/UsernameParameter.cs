using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyControls
{
    public class UsernameParameter : Parameter
    {
        protected override object Evaluate(HttpContext context, Control control)
        {
            if (context != null)
                return context.User.Identity.Name;
            else
                return null;
        }
    }
}