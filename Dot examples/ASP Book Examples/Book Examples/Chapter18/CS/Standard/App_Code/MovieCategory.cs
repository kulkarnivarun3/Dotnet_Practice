using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;

public partial class MovieCategory
{
    public static IEnumerable<MovieCategory> Select()
    {
        MyDatabaseDataContext db = new MyDatabaseDataContext();
        return db.MovieCategories;
    }



}
