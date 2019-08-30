using System;
using System.Configuration;
using System.Web.Configuration;

/// <summary>
/// Summary description for BlogSection
/// </summary>
public class BlogSection : ConfigurationSection
{

    [ConfigurationProperty("title", IsRequired = true)]
    public string Title
    {
        get { return this["title"].ToString(); }
        set { this["title"] = value; }
    }


    [ConfigurationProperty("description", IsRequired = true)]
    public string Description
    {
        get { return this["description"].ToString(); }
        set { this["description"] = value; }
    }


    [ConfigurationProperty("url", IsRequired = true)]
    public string Url
    {
        get { return this["url"].ToString(); }
        set { this["url"] = value; }
    }


    public BlogSection()
    {
    }
}

