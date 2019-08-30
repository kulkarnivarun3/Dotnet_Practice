using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Linq.Expressions;
using System.Reflection;

public partial class Movie
{



    public static IEnumerable<Movie> Select(string orderBy)
    {
        string orderByColumn = "Id";
        string orderByDirection = "asc";
        if (!String.IsNullOrEmpty(orderBy))
            ParseOrderBy(orderBy, ref orderByColumn, ref orderByDirection);


        MyDatabaseDataContext db = new MyDatabaseDataContext();
        if (orderByDirection == "asc")
            return db.Movies.OrderBy(GetDynamicSort(orderByColumn));
        else
            return db.Movies.OrderByDescending(GetDynamicSort(orderByColumn));
    }



    public static void ParseOrderBy
    (
      string orderBy,
      ref string orderByColumn,
      ref string orderByDirection
    )
    {
        string[] orderByParts = orderBy.Split(' ');
        orderByColumn = orderByParts[0];
        if (orderByParts.Length > 1)
            orderByDirection = orderByParts[1].ToLower();
    }


    private static Expression<Func<Movie, string>> GetDynamicSort(string orderByColumn)
    {
        // Create expression to represent Movie parameter into lambda expression
        ParameterExpression pMovie = Expression.Parameter(typeof(Movie), "m");

        // Create expression to access value of order by column 
        PropertyInfo propInfo = typeof(Movie).GetProperty(orderByColumn);
        MemberExpression m = Expression.MakeMemberAccess(pMovie, propInfo);

        // Box it
        UnaryExpression b = Expression.TypeAs(m, typeof(object));

        // Convert to string
        MethodInfo convertMethod = typeof(Convert).GetMethod("ToString",
            new Type[] { typeof(object) });
        MethodCallExpression c = Expression.Call(null, convertMethod, b);

        // Return lambda
        return Expression.Lambda<Func<Movie, string>>(c, pMovie);
    }



    public static void Delete(Movie movieToDelete)
    {
        MyDatabaseDataContext db = new MyDatabaseDataContext();
        db.Movies.Attach(movieToDelete);
        db.Movies.DeleteOnSubmit(movieToDelete);
        db.SubmitChanges();
    }



    public static void Update(Movie oldMovie, Movie newMovie)
    {
        MyDatabaseDataContext db = new MyDatabaseDataContext();
        db.Movies.Attach(newMovie, oldMovie);
        db.SubmitChanges();
    }



    public static int Insert(Movie movieToInsert)
    {
        MyDatabaseDataContext db = new MyDatabaseDataContext();
        db.Movies.InsertOnSubmit(movieToInsert);
        db.SubmitChanges();
        return movieToInsert.Id;
    }


    public static IEnumerable<Movie> SelectCached()
    {
        HttpContext context = HttpContext.Current;
        List<Movie> movies = (List<Movie>)context.Cache["Movies"];
        if (movies == null)
        {
            movies = Select().ToList();
            context.Cache["Movies"] = movies;
            context.Trace.Warn("Retrieving movies from database");
        }
        return movies;
    }



    public static IEnumerable<Movie> Select()
    {
        MyDatabaseDataContext db = new MyDatabaseDataContext();
        return db.Movies;
    }

    public static IEnumerable<Movie> SelectPaged(int startRowIndex, int maximumRows)
    {
        return Select().Skip(startRowIndex).Take(maximumRows);
    }

    public static int SelectCount()
    {
        return Select().Count();
    }
}
