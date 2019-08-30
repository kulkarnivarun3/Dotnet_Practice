using System;
using System.Web.Configuration;
using System.ServiceModel.Syndication;


/// <summary>
/// Summary description for FeedHelper
/// </summary>
public class FeedHelper
{

    public static SyndicationFeed GetFeed()
    {

        BlogSection config = (BlogSection)WebConfigurationManager.GetSection("blog");
        SyndicationFeed feed = new SyndicationFeed(config.Title, config.Description, new Uri(config.Url), Blog.SelectFeed());    
        feed.BaseUri = new Uri(config.Url);
        return feed;
    }

}
