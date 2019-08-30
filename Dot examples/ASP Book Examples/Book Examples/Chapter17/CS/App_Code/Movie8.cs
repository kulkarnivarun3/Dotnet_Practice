using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Collections.Generic;

public class Movie8
{
    private static readonly string _connectionString;

    public DataTable GetAll()
    {
        // Initialize the DataAdapter
        SqlDataAdapter dad = new SqlDataAdapter("SELECT Title,Director FROM Movies", _connectionString);

        // Create a DataTable
        DataTable dtblMovies = new DataTable();

        // Populate the DataTable
        dad.Fill(dtblMovies);

        // Return results
        return dtblMovies;
    }

    static Movie8()
    {
        _connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }
}
