using System;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace myControls
{

    /// <summary>
    /// Displays Number of Users Online
    /// </summary>
    public class UsersOnline : WebControl
    {
        protected override void RenderContents(HtmlTextWriter writer)
        {
            writer.Write(Membership.GetNumberOfUsersOnline());
        }

    }
}