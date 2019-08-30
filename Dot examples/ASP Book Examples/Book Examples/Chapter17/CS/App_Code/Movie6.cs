using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Collections.Generic;

public class Movie6
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

    public List<Movie6> GetAll()
    {
        List<Movie6> results = new List<Movie6>();
        SqlConnection con = new SqlConnection(_connectionString);
        SqlCommand cmd = new SqlCommand("SELECT Title,Director FROM Movies", con);
        using (con)
        {
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                Movie6 newMovie = new Movie6();
                newMovie.Title = (string)reader["Title"];
                newMovie.Director = (string)reader["Director"];
                results.Add(newMovie);
            }
        }
        return results;
    }

    static Movie6()
    {
        _connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }
}
