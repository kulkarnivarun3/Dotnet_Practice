using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public class Movies
{
    private readonly string _conString;

    public void UpdateMovie(int id, string title, string director, DateTime dateReleased)
    {
        // Create Command
        SqlConnection con = new SqlConnection(_conString);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "UPDATE Movies SET Title=@Title,Director=@Director,DateReleased=@DateReleased WHERE Id=@Id";

        // Add parameters
        cmd.Parameters.AddWithValue("@Title", title);
        cmd.Parameters.AddWithValue("@Director", director);
        cmd.Parameters.AddWithValue("@DateReleased", dateReleased);
        cmd.Parameters.AddWithValue("@Id", id);

        // Execute command
        using (con)
        {
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    public SqlDataReader GetMovies()
    {
        // Create Connection
        SqlConnection con = new SqlConnection(_conString);

        // Create Command
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "SELECT Id,Title,Director,DateReleased FROM Movies";

        // Return DataReader
        con.Open();
        return cmd.ExecuteReader(CommandBehavior.CloseConnection);
    }

    public Movies()
    {
        _conString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }
}
