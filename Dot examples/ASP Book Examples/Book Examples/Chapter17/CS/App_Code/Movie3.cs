using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Collections.Generic;

public class Movie3
{
    private static readonly string _connectionString;

    private int _id;
    private string _title;
    private string _director;

    public int Id
    {
        get { return _id; }
        set { _id = value; }
    }

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

    public void Update(int id, string title, string director)
    {
        SqlConnection con = new SqlConnection(_connectionString);
        SqlCommand cmd = new SqlCommand("UPDATE MOVIES SET Title=@Title,Director=@Director WHERE Id=@Id", con);
        cmd.Parameters.AddWithValue("@Title", title);
        cmd.Parameters.AddWithValue("@Director", director);
        cmd.Parameters.AddWithValue("@Id", id);
        using (con)
        {
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    public void Delete(int id)
    {
        SqlConnection con = new SqlConnection(_connectionString);
        SqlCommand cmd = new SqlCommand("DELETE MOVIES WHERE Id=@Id", con);
        cmd.Parameters.AddWithValue("@Id", id);
        using (con)
        {
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    public List<Movie3> GetAll()
    {
        List<Movie3> results = new List<Movie3>();
        SqlConnection con = new SqlConnection(_connectionString);
        SqlCommand cmd = new SqlCommand("SELECT Id,Title,Director FROM Movies", con);
        using (con)
        {
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                Movie3 newMovie = new Movie3();
                newMovie.Id = (int)reader["Id"];
                newMovie.Title = (string)reader["Title"];
                newMovie.Director = (string)reader["Director"];
                results.Add(newMovie);
            }
        }
        return results;
    }

    static Movie3()
    {
        _connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }
}
