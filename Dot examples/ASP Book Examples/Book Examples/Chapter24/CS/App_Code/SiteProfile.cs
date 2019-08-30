using System;
using System.Web.Profile;

public class SiteProfile : ProfileBase
{
    private string _firstName = "Your First Name";
    private string _lastName = "Your Last Name";

    [SettingsAllowAnonymous(true)]
    public string FirstName
    {
        get { return _firstName; }
        set { _firstName = value; }
    }

    [SettingsAllowAnonymous(true)]
    public string LastName
    {
        get { return _lastName; }
        set { _lastName = value; }
    }
}
