using System;
using System.Linq;
using System.Data.Linq.Mapping;
using System.Xml.Linq;
using System.Collections;
using System.Collections.Generic;

/// <summary>
/// Summary description for Entry
/// </summary>
public partial class Entry : EntityBase<Entry>
{

    public static IEnumerable SelectByTag(string tag)
    {
        return EntryTag.Table
        .Where(t => t.Name == tag)
        .Join(Table, t => t.EntryId, e => e.Id, (id, e) => e)
        .Join
            (
                WebUser.Table,
                e => e.AuthorUserName,
                w => w.UserName,
                (e, w) => new { Id = e.Id, Title = e.Title, IntroductionText = e.IntroductionText, AuthorUserName = e.AuthorUserName, Rating = (double?)EntryRating.Table.Where(r => r.EntryId == e.Id).Average(r => (double?)r.Rating), DateCreated = e.DateCreated, FirstName = w.FirstName, LastName = w.LastName }
            )
        .OrderByDescending(e => e.Rating)
        .Distinct();
    }


    public object GetFull(int id)
    {
        // update count
        Entry currentEntry = Get(id);
        currentEntry.ViewCount ++;
        Context.SubmitChanges();
    
        // get full record
        return Table.Where( e => e.Id == id)
        .Join
            (
                WebUser.Table,
                e => e.AuthorUserName,
                w => w.UserName,
                (e, w) => new { Id = e.Id, Version = e.Version,  ViewCount = e.ViewCount, Title = e.Title, AuthorUserName = e.AuthorUserName, Description = e.Description, Rating = EntryRating.Table.Where(r => r.EntryId == e.Id).Average(r => (double?)r.Rating), DateCreated = e.DateCreated, FirstName = w.FirstName, LastName = w.LastName }
            ).Single();
    }


    public static IEnumerable SelectByRating()
    {
        return Table
        .Join
            (
                WebUser.Table,
                e => e.AuthorUserName,
                w => w.UserName,
                (e, w) => new { Id = e.Id, Title = e.Title, IntroductionText= e.IntroductionText, AuthorUserName = e.AuthorUserName, Rating = (double?)EntryRating.Table.Where(r => r.EntryId == e.Id).Average(r => (double?)r.Rating), DateCreated = e.DateCreated, FirstName = w.FirstName, LastName = w.LastName }
            )
        .OrderByDescending(e => e.Rating)
        .Take(10);
    }



    public static IEnumerable SelectByRecent()
    {
        return Table
        .Join
            (
                WebUser.Table,
                e => e.AuthorUserName,
                w => w.UserName,
                (e, w) => new { Id = e.Id, Title = e.Title, IntroductionText = e.IntroductionText, AuthorUserName = e.AuthorUserName, Rating = (double?)EntryRating.Table.Where(r => r.EntryId == e.Id).Average(r => (double?)r.Rating), DateCreated = e.DateCreated, FirstName = w.FirstName, LastName = w.LastName }
            )
        .OrderByDescending(e => e.DateCreated)
        .Take(10);
    }




    public static IEnumerable SelectByViews()
    {
        return Table
        .Join
            (
                WebUser.Table,
                e => e.AuthorUserName,
                w => w.UserName,
                (e, w) => new { Id = e.Id, ViewCount = e.ViewCount, Title = e.Title, IntroductionText = e.IntroductionText, AuthorUserName = e.AuthorUserName, Rating = (double?)EntryRating.Table.Where(r => r.EntryId == e.Id).Average(r => (double?)r.Rating), DateCreated = e.DateCreated, FirstName = w.FirstName, LastName = w.LastName }
            )
        .OrderByDescending(e => e.ViewCount)
        .Take(10);
    }



    public static string[] GetSuggestions(string prefixText, int count)
    {
        return Table.Where(e => e.Title.Contains(prefixText)).Select( e => e.Title).Take(count).ToArray();
    }


    public static IEnumerable<Entry> SelectByTitle(string title)
    {
        return Table.Where(e => e.Title.Contains(title));
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
    
        if (!ValidationUtility.SatisfiesRequired(Title))
            ValidationErrors.Add("Title", "Title is required", "required");

        if (!ValidationUtility.SatisfiesRequired(IntroductionText))
            ValidationErrors.Add("IntroductionText", "Introduction text is required", "required");

        if (IntroductionText.Length > 300)
            ValidationErrors.Add("IntroductionText", "Introduction text is too long");
            
        if (!ValidationUtility.SatisfiesRequired(Description))           
            ValidationErrors.Add("Description", "Description is required", "required");
    }


    

    

}
