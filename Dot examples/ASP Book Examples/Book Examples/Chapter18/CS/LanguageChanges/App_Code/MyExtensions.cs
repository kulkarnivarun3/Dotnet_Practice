public static class MyExtensions
{
    public static string HtmlEncode(this string str)
    {
        return System.Web.HttpUtility.HtmlEncode(str);
    }
}
