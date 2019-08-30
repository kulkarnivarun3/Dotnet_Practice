using System;
using System.Web.Configuration;
using System.Collections.Generic;

public class MovieCollection
{
    public List<string> GetMovies()
    {
        List<string> movies = new List<string>();
        movies.Add("Star Wars");
        movies.Add("Independence Day");
        movies.Add("War of the Worlds");
        return movies;
    }

}
