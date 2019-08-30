using System;
using System.Data.Linq.Mapping;

/// <summary>
/// Summary description for Book
/// </summary>
public partial class Book: EntityBase<Book>
{

    protected override void Validate()
    {

        if (!ValidationUtility.SatisfiesRequired(Title))
            ValidationErrors.Add("Title", "Title is required", "required");
        if (!ValidationUtility.SatisfiesRequired(Authors))
            ValidationErrors.Add("Authors", "Authors is required", "required");
        if (!ValidationUtility.SatisfiesRequired(Description))
            ValidationErrors.Add("Description", "Description is required", "required");
        if (!ValidationUtility.SatisfiesType(BuyLink, "url"))
            ValidationErrors.Add("BuyLink", "Buy link is invalid URL", "invalid");

    }



}
