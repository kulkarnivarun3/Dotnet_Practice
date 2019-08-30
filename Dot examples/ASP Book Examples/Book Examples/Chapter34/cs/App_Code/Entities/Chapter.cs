using System;
using System.Linq;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Data.Linq;

/// <summary>
/// Summary description for Chapter
/// </summary>
public partial class Chapter : EntityBase<Chapter>
{

    public static IEnumerable<Chapter> SelectByBookId(int bookId)
    {
        return Table.Where( c => c.BookId == bookId ).OrderBy( c => c.OrderNumber);
    }



    protected override void Validate()
    {
        if (!ValidationUtility.SatisfiesRequired(Title))
            ValidationErrors.Add("Title", "Title is required", "required");
        if (!ValidationUtility.SatisfiesRequired(Description))
            ValidationErrors.Add("Description", "Description is required", "required");

    }
    




}
