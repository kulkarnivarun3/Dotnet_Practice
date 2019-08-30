using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Collections.Generic;

public class AsyncDataLayer
{
    private static readonly string _connectionString;
    private SqlCommand _cmdMovies;

    public IAsyncResult BeginGetMovies(AsyncCallback callback, Object state)
    {
        SqlConnection con = new SqlConnection(_connectionString);
        _cmdMovies = new SqlCommand("WAITFOR DELAY '0:0:01';SELECT Title,Director FROM Movies", con);
        con.Open();
        return _cmdMovies.BeginExecuteReader(callback, state, CommandBehavior.CloseConnection);
    }

    public List<AsyncDataLayer.Movie> EndGetMovies(IAsyncResult result)
    {
        List<AsyncDataLayer.Movie> results = new List<AsyncDataLayer.Movie>();
        SqlDataReader reader = _cmdMovies.EndExecuteReader(result);
        while (reader.Read())
        {
            AsyncDataLayer.Movie newMovie = new AsyncDataLayer.Movie();
            newMovie.Title = (string)reader["Title"];
            newMovie.Director = (string)reader["Director"];
            results.Add(newMovie);
        }
        return results;
    }

    static AsyncDataLayer()
    {
        _connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString
            + ";Asynchronous Processing=true";
    }

    public class Movie
    {
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
    }
}
