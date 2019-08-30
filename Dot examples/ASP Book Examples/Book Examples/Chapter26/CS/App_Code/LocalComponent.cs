using System;
using System.Web;

public class LocalComponent
{
    public static string getResource()
    {
        return (string)HttpContext.GetLocalResourceObject("~/LocalizablePage.aspx", "ClickHere");
    }
}
