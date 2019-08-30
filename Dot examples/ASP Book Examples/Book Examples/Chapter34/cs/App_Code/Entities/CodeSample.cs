using System;
using System.Linq;
using System.Data.Linq.Mapping;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// Summary description for Entry
/// </summary>
public partial class CodeSample : EntityBase<CodeSample>
{

    public IEnumerable<CodeSample> SelectByEntryId(int entryId)
    {
        return Table.Where( s => s.EntryId == entryId );
    }

    protected override void Validate()
    {

        // Security check
        if (!ValidationUtility.IsInRole("Administrators"))
        {
            string userName = HttpContext.Current.User.Identity.Name;
            Entry entry = Entry.Table.Where(e => e.Id == EntryId && e.AuthorUserName == userName).SingleOrDefault();
            if (entry == null)
                ValidationErrors.Add("AuthorUserName", "Only the original author or an administrator can modify this code sample");
        }


        if (!ValidationUtility.SatisfiesRequired(FileName))
            ValidationErrors.Add("FileName", "File Name is required", "required");

        if (LanguageId == -1)
            ValidationErrors.Add("LanguageId", "Select a language");

        if (!ValidationUtility.SatisfiesRequired(Description))
            ValidationErrors.Add("Description", "Description is required", "required");

        if (!ValidationUtility.SatisfiesRequired(Code))
            ValidationErrors.Add("Code", "Code is required", "required");


    }


    partial void OnCreated()
    {
        this.LanguageId = -1;
    }


}
