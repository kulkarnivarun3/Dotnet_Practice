using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Superexpert.Controls
{

    /// <summary>
    /// Summary description for UserNameParameter
    /// </summary>
    public class UserNameParameter : Parameter
    {
        protected override object Evaluate(HttpContext context, Control control)
        {
            return context.User.Identity.Name;
        }

    }

}