using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public class MoviesByCategory
{
    private readonly string _conString;
    private readonly string _movieCategory;

    public SqlDataReader GetMovies()
    {
        // Initialize connection     
        SqlConnection con = new SqlConnection(_conString);

        // Initialize command
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "SELECT Title,Director,DateReleased FROM Movies"
            + " JOIN MovieCategories ON Movies.CategoryId=MovieCategories.Id"
            + " WHERE MovieCategories.Name=@CategoryName";

        // Create ADO.NET parameters
        cmd.Parameters.AddWithValue("@CategoryName", _movieCategory);

        // Execute command
        con.Open();
        return cmd.ExecuteReader(CommandBehavior.CloseConnection);
    }

    public MoviesByCategory(string movieCategory)
    {
        _movieCategory = movieCategory;
        _conString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }
}
