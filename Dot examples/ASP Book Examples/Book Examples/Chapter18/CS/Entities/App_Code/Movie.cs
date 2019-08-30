using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;

public partial class Movie
{
    public static IEnumerable<Movie> Select()
    {
        MyDatabaseDataContext db = new MyDatabaseDataContext();
        return db.Movies;
    }

    public static IEnumerable<Movie> SelectByBoxOfficeTotals()
    {
        return Select().OrderBy(m => m.BoxOfficeTotals);
    }
}
