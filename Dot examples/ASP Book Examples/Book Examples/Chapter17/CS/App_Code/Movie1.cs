using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Collections.Generic;

public class Movie1
{
    private static readonly string _connectionString;

    private string _title;
    private string _director;

    public string Title
    {
        get { return _title; }
        set { _title = value; }
    }

    public string Director
    {
        get { return _director; }
        set { _director = value; }
    }

    public List<Movie1> GetAll()
    {
        List<Movie1> results = new List<Movie1>();
        SqlConnection con = new SqlConnection(_connectionString);
        SqlCommand cmd = new SqlCommand("SELECT Title,Director FROM Movies", con);
        using (con)
        {
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                Movie1 newMovie = new Movie1();
                newMovie.Title = (string)reader["Title"];
                newMovie.Director = (string)reader["Director"];
                results.Add(newMovie);
            }
        }
        return results;
    }

    static Movie1()
    {
        _connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }
}
