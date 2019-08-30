using System;
using System.Linq;
using System.Data.Linq.Mapping;
using System.Collections;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// Summary description for Tag
/// </summary>
public partial class EntryTag: EntityBase<EntryTag>
{

    public IEnumerable<EntryTag> SelectByEntryId(int entryId)
    {
        return Table.Where( t => t.EntryId == entryId );
    }


    public static IEnumerable<CloudItem> SelectTagCloud()
    {
        return Table.GroupBy( t => t.Name ).Select( g => new CloudItem{Name = g.Key, Count= g.Count()} ).OrderBy( a => a.Name );
    }



    public override void Insert()
    {
        int count = Table.Where( t => t.EntryId == EntryId ).Count();
        if (count < 3)
            base.Insert();
        //else 
        //    ValidationErrors.AddAndThrow("Name", "You cannot add more than 3 tags");
    }


    public static string[] GetSuggestions(string prefixText, int count)
    {
        return Table.Where(t => t.Name.StartsWith(prefixText)).Select(t => t.Name).Distinct().Take(count).ToArray();
    }




    protected override void Validate()
    {
        // Security check
        if (!ValidationUtility.IsInRole("Administrators"))
        {
            string userName = HttpContext.Current.User.Identity.Name;
            Entry entry = Entry.Table.Where( e => e.Id == EntryId && e.AuthorUserName == userName ).SingleOrDefault();
            if (entry == null)
                ValidationErrors.Add("AuthorUserName", "Only the original author or an administrator can modify these tags");
        }

 
        if (!ValidationUtility.SatisfiesRequired(Name))
            ValidationErrors.Add("Name", "Required");    
    }
}
