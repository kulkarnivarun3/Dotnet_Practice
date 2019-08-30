using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public class MovieCategories
{
    private readonly string _conString;

    public SqlDataReader GetMovies(int categoryId)
    {
        // Create Connection
        SqlConnection con = new SqlConnection(_conString);

        // Create Command
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "SELECT Id,Title,Director,DateReleased "
            + " FROM Movies WHERE CategoryId=@CategoryId";

        // Add parameters
        cmd.Parameters.AddWithValue("@CategoryId", categoryId);

        // Return DataReader
        con.Open();
        return cmd.ExecuteReader(CommandBehavior.CloseConnection);
    }

    public SqlDataReader GetCategories()
    {
        // Create Connection
        SqlConnection con = new SqlConnection(_conString);

        // Create Command
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "SELECT Id,Name FROM MovieCategories";

        // Return DataReader
        con.Open();
        return cmd.ExecuteReader(CommandBehavior.CloseConnection);
    }

    public MovieCategories()
    {
        _conString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }
}
