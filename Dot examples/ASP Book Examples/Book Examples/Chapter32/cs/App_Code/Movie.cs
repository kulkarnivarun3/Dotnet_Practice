using System;
using System.Collections;
using System.Linq;

public partial class Movie
{

    public static IEnumerable Select()
    {
        MyDatabaseDataContext db = new MyDatabaseDataContext();
        return db.Movies.Select(m => new {m.Id, m.Title, m.Director});
    }
    
    public static void Insert(string title, string director)
    {
        MyDatabaseDataContext db = new MyDatabaseDataContext();
        Movie movieToAdd = new Movie();
        movieToAdd.Title = title;
        movieToAdd.Director = director;
        movieToAdd.CategoryId = 1;
        movieToAdd.DateReleased = DateTime.Now;
        db.Movies.InsertOnSubmit( movieToAdd );
        db.SubmitChanges();        
    }

}
