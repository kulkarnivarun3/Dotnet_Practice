using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public class InsertMovie
{
    private static readonly string _conString;

    public static SqlDataReader GetMovies()
    {
        // Initialize connection     
        SqlConnection con = new SqlConnection(_conString);

        // Initialize command
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "SELECT Id,Title,Director FROM Movies";

        // Execute command
        con.Open();
        return cmd.ExecuteReader(CommandBehavior.CloseConnection);
    }

    public static void Insert(string title, string director)
    {
        // Initialize connection     
        SqlConnection con = new SqlConnection(_conString);

        // Initialize command
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "INSERT Movies (Title,Director)" +
            " VALUES (@Title,@Director)";

        // Add ADO.NET parameters
        cmd.Parameters.AddWithValue("@Title", title);
        cmd.Parameters.AddWithValue("@Director", director);

        // Execute command
        using (con)
        {
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    static InsertMovie()
    {
        _conString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }

}
