using System;

public partial class Movie : EntityBase<Movie>
{
    protected override void Validate()
    {
        // Title is required
        if (!ValidationUtility.SatisfiesRequired(Title))
            ValidationErrors.Add("Title", "Required");
        // Director is required
        if (!ValidationUtility.SatisfiesRequired(Director))
            ValidationErrors.Add("Director", "Required");
        // DateReleased is required
        if (DateReleased == DateTime.MinValue)
            ValidationErrors.Add("DateReleased", "Required");
        // DateReleased can't be more than 10 years ago
        if ((DateTime.Now.Year - DateReleased.Year) > 10)
            ValidationErrors.AddIfNotAlready("DateReleased", "Movie too old");
    }
}
