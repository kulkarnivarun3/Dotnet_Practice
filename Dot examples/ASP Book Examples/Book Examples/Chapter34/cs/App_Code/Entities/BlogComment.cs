using System;
using System.Collections;
using System.Web;
using System.Linq;
using System.Data.Linq.Mapping;
using System.Collections.Generic;


/// <summary>
/// Summary description for BlogComment
/// </summary>
public partial class BlogComment: EntityBase<BlogComment>
{
    public static IEnumerable Select(int blogId, int startRowIndex, int maximumRows)
    {
        return Table.Where(c => c.BlogId == blogId).OrderBy( c => c.Id)
        .Join
            (
                WebUser.Table,
                c => c.AuthorUserName,
                w => w.UserName,
                (c, w) => new {Id = c.Id, Title = c.Title, Comment = c.Comment, AuthorUserName = c.AuthorUserName, Version = c.Version, DateCreated = c.DateCreated, FirstName = w.FirstName, LastName = w.LastName, WebsiteUrl = w.WebsiteUrl}
            )
        .OrderByDescending(a => a.Id)     
        .Skip(startRowIndex)
        .Take(maximumRows);  
    }
    
    
    public static int SelectCountCached(int blogId)
    {
        return Table.Where(c => c.BlogId == blogId).Count();
    }




    protected override void Validate()
    {
        // Security check
        // Only the administrator or original author can modify this comment
        if (!ValidationUtility.IsInRole("Administrators"))
        {
            if (!ValidationUtility.IsUserName(AuthorUserName))
                ValidationErrors.Add("AuthorUserName", "Only the original author or administrator can modify this comment"); 
        }

        // Check for required
        if (!ValidationUtility.SatisfiesRequired(Title))
            ValidationErrors.Add("Title", "Title is required", "Required");

        if (!ValidationUtility.SatisfiesRequired(Comment))
            ValidationErrors.Add("Comment", "Comment is required", "Required");

    }
}
