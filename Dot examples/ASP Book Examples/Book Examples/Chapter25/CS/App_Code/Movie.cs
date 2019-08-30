using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public class Movie
{
    public static DataTable GetMovies()
    {
        string conString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
        SqlDataAdapter dad = new SqlDataAdapter("SELECT Title,Director FROM Movies", conString);
        DataTable movies = new DataTable();
        dad.Fill(movies);
        return movies;
    }
}
