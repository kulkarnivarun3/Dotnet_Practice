using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Linq.Mapping;
using System.Linq;

/// <summary>
/// Summary description for BlogTag
/// </summary>
public partial class BlogTag : EntityBase<BlogTag>
{
    public static string[] GetSuggestions(string prefixText, int count)
    {
        return Table.Where( t => t.Name.StartsWith(prefixText) ).Select(t => t.Name).Distinct().Take(count).ToArray();
    }


    public IEnumerable<BlogTag> SelectByBlogId(int blogId)
    {
        return Table.Where(c => c.BlogId == blogId).OrderBy( c => c.Name); 
    }



    protected override void Validate()
    {
        if (!ValidationUtility.SatisfiesRequired(Name))
            ValidationErrors.Add("Name", "Tag name is required");
    }
}
