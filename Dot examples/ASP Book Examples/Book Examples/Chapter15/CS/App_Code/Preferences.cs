using System.Web;

public class Preferences
{

    public static string FavoriteColor
    {
        get
        {
            HttpContext context = HttpContext.Current;
            context.Trace.Warn("Getting FavoriteColor");
            if (context.Session["FavoriteColor"] == null)
                return "Blue";
            else
                return (string)context.Session["FavoriteColor"];
        }
        set
        {
            HttpContext context = HttpContext.Current;
            context.Trace.Warn("Setting FavoriteColor");
            context.Session["FavoriteColor"] = value;
        }
    }


}
