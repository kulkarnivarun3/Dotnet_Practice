using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public class MovieDataReader
{
    private readonly string _conString;

    public SqlDataReader GetMovies()
    {
        // Create Connection
        SqlConnection con = new SqlConnection(_conString);

        // Create Command
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "SELECT Id,Title,Director FROM Movies";

        // Return DataReader
        con.Open();
        return cmd.ExecuteReader(CommandBehavior.CloseConnection);
    }


    public MovieDataReader()
    {
        _conString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }
}
