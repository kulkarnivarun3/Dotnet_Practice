using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Collections.Generic;

public class DataLayer1
{
    private static readonly string _connectionString;

    public class MovieCategory
    {
        private int _id;
        private string _name;

        public int Id
        {
            get { return _id; }
            set { _id = value; }
        }

        public string Name
        {
            get { return _name; }
            set { _name = value; }
        }
    }

    public class Movie
    {
        private string _title;
        private int _categoryId;

        public string Title
        {
            get { return _title; }
            set { _title = value; }
        }

        public int CategoryId
        {
            get { return _categoryId; }
            set { _categoryId = value; }
        }
    }

    public static void GetMovieData(List<DataLayer1.MovieCategory> movieCategories, List<DataLayer1.Movie> movies)
    {
        string commandText = "SELECT Id,Name FROM MovieCategories;SELECT Title,CategoryId FROM Movies";
        SqlConnection con = new SqlConnection(_connectionString);
        SqlCommand cmd = new SqlCommand(commandText, con);
        using (con)
        {
            // Execute command
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            // Create movie categories
            while (reader.Read())
            {
                DataLayer1.MovieCategory newCategory = new DataLayer1.MovieCategory();
                newCategory.Id = (int)reader["Id"];
                newCategory.Name = (string)reader["Name"];
                movieCategories.Add(newCategory);
            }

            // Move to next result set
            reader.NextResult();

            // Create movies
            while (reader.Read())
            {
                DataLayer1.Movie newMovie = new DataLayer1.Movie();
                newMovie.Title = (string)reader["Title"];
                newMovie.CategoryId = (int)reader["CategoryID"];
                movies.Add(newMovie);
            }
        }
    }

    static DataLayer1()
    {
        _connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }
}
