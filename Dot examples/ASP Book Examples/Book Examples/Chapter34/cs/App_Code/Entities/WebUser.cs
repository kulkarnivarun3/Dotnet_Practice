using System;
using System.Linq;
using System.Data.Linq;
using System.Data.Linq.Mapping;

/// <summary>
/// Summary description for WebUser
/// </summary>
public partial class WebUser: EntityBase<WebUser>
{


    public static WebUser Get(string userName)
    {
        WebUser match = Table.Where( w => w.UserName == userName ).SingleOrDefault();
        if (match == null)
            return new WebUser();
        return match;
    }


    public override void Save(WebUser newEntity)
    {
        newEntity.PerformValidation();
        WebUser match = Table.Where(w => w.UserName == newEntity.UserName).SingleOrDefault();
        if (match == null)
        {
            newEntity.Insert();
        }
        else
        {
            match.FirstName = newEntity.FirstName;
            match.LastName = newEntity.LastName;
            match.WebsiteUrl = newEntity.WebsiteUrl;
            match.Profile = newEntity.Profile;
            match.ReceiveNewsletter = newEntity.ReceiveNewsletter;
            Table.Context.SubmitChanges();
        }
    }




    protected override void Validate()
    {
        if (!ValidationUtility.SatisfiesRequired(FirstName))
            ValidationErrors.Add("FirstName", "Required");
        if (!ValidationUtility.SatisfiesRequired(LastName))
            ValidationErrors.Add("LastName", "Required");
        if (!String.IsNullOrEmpty(WebsiteUrl) && !ValidationUtility.SatisfiesType(WebsiteUrl, "url"))
            ValidationErrors.AddIfNotAlready("WebsiteUrl", "Invalid website address");
    }



    

}
