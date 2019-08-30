using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Web;

public class MoviesDSPaging
{

    public static IEnumerable<Movie> GetMovies(int startRowIndex, int maximumRows)
    {
        MyDatabaseDataContext db = new MyDatabaseDataContext();
        return db.Movies.Skip(startRowIndex).Take(maximumRows);
    } 


    public static int GetMovieCount()
    {
        HttpContext context = HttpContext.Current;
        if (context.Cache["MovieCount"] == null)
            context.Cache["MovieCount"] = GetMovieCountFromDB();
        return (int)context.Cache["MovieCount"];
    }

    private static int GetMovieCountFromDB()
    {
        MyDatabaseDataContext db = new MyDatabaseDataContext();
        return db.Movies.Count();
    }
}
