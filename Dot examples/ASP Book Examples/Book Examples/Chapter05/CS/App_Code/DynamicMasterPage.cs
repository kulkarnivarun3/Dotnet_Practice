using System;
using System.Web.UI;
using System.Web.Profile;

public class DynamicMasterPage : Page
{

    protected override void OnPreInit(EventArgs e)
    {
        this.MasterPageFile = (string)Context.Profile["MasterPageFile"];
        base.OnPreInit(e);
    }

}
