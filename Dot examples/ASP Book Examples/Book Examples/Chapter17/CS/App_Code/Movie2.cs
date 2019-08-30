using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Collections;
using System.Collections.Generic;

public class Movie2
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

    public List<Movie2> GetAll(out long executionTime)
    {
        List<Movie2> results = new List<Movie2>();
        SqlConnection con = new SqlConnection(_connectionString);
        SqlCommand cmd = new SqlCommand("WAITFOR DELAY '0:0:03';SELECT Title,Director FROM Movies", con);
        con.StatisticsEnabled = true;
        using (con)
        {
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                Movie2 newMovie = new Movie2();
                newMovie.Title = (string)reader["Title"];
                newMovie.Director = (string)reader["Director"];
                results.Add(newMovie);
            }
        }
        IDictionary stats = con.RetrieveStatistics();
        executionTime = (long)stats["ExecutionTime"];
        return results;
    }

    static Movie2()
    {
        _connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }
}
