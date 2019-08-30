using System;
using System.Linq;
using System.Data.Linq;
using System.Data.Linq.Mapping;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Configuration;
using System.ServiceModel.Syndication;

/// <summary>
/// Represents a blog entry
/// </summary>
public partial class Blog : EntityBase<Blog>
{
    /// <summary>
    /// Returns a brief blog entry (not including post) with paging 
    /// </summary>
    public static IEnumerable<BriefBlog> SelectBriefByTag(string tagName, int startRowIndex, int maximumRows)
    {
        return SelectBriefByTag(tagName).Skip(startRowIndex).Take(maximumRows); 
    }


    /// <summary>
    /// Get full blog entry (including WebUser and comment count)
    /// </summary>
    public static FullBlog GetFull(int id)
    {
        return Table
        .Where( b => b.Id == id)
        .Join
            (
                WebUser.Table,
                b => b.AuthorUserName,
                w => w.UserName,
                (b, w) => new FullBlog { Id = b.Id, Version = b.Version, IsPinned = b.IsPinned, Title = b.Title, AuthorUserName = b.AuthorUserName, IntroductionText = b.IntroductionText, Post = b.Post, DateCreated = b.DateCreated, FirstName = w.FirstName, LastName = w.LastName, CommentCount = BlogComment.Table.Where(c => c.BlogId == b.Id).Count() }
            )
        .Single();
    }


    /// <summary>
    /// Retrieves brief blog entry filtering by blog tag
    /// </summary>
    public static IEnumerable<BriefBlog> SelectBriefByTag(string tagName)
    {
        return BlogTag.Table
        .Where(t => t.Name == tagName)
        .Select(t => t.BlogId)
        .Join(Table, id => id, b => b.Id, (id, b) => b)
        .Join
            (
                WebUser.Table,
                b => b.AuthorUserName,
                w => w.UserName,
                (b, w) => new BriefBlog { Id = b.Id, Title = b.Title, AuthorUserName = b.AuthorUserName, IntroductionText = b.IntroductionText, DateCreated = b.DateCreated, FirstName = w.FirstName, LastName = w.LastName, CommentCount = BlogComment.Table.Where(c => c.BlogId == b.Id).Count()}
            )
            .OrderByDescending(b => b.Id);
    }


    /// <summary>
    /// Select count of brief blog entries by tag
    /// </summary>
    public static int SelectBriefCountByTag(string tagName)
    {
        return SelectBriefByTag(tagName).Count();
    }



    public static IEnumerable<BriefBlog> SelectBrief(int startRowIndex, int maximumRows)
    {
        return Table
        .Join
            (
                WebUser.Table,
                b => b.AuthorUserName,
                w => w.UserName,
                (b, w) => new BriefBlog {Id = b.Id, IsPinned = b.IsPinned, Title = b.Title, AuthorUserName = b.AuthorUserName, IntroductionText = b.IntroductionText, DateCreated = b.DateCreated, FirstName = w.FirstName, LastName = w.LastName, CommentCount = BlogComment.Table.Where( c => c.BlogId == b.Id).Count() }
            )
            .OrderByDescending(b => b.IsPinned)
            .ThenByDescending(b => b.Id)
            .Skip(startRowIndex).Take(maximumRows);
    }


    /// <summary>
    /// Used for both RSS and Atom feeds
    /// </summary>
    /// <returns></returns>
    public static IEnumerable<SyndicationItem> SelectFeed()
    {
        BlogSection config = (BlogSection)WebConfigurationManager.GetSection("blog");
        string url = config.Url;
        List<Blog> items = Select("Id Desc").ToList();
        return items.Select(b => new SyndicationItem(b.Title, b.IntroductionText, new Uri(String.Format("{0}/Blog/Default.aspx?blogId={1}", url, b.Id)), String.Format("{0}/Blog/Default.aspx?blogId={1}", url, b.Id), b.DateCreated));
    }


    /// <summary>
    /// Where all validation happens
    /// </summary>
    protected override void Validate()
    {
        // Required fields
        if (!ValidationUtility.SatisfiesRequired(Title))
            ValidationErrors.Add("Title", "Required");
        if (!ValidationUtility.SatisfiesRequired(IntroductionText))
            ValidationErrors.Add("IntroductionText", "Required");
        if (!ValidationUtility.SatisfiesRequired(Post))
            ValidationErrors.Add("Post", "Required");                       
    }
}
