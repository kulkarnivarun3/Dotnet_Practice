using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public class ConflictedMovies
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

    public static void UpdateMovie(string title, string director, string original_title, string original_director, int original_id)
    {
        // Initialize connection     
        SqlConnection con = new SqlConnection(_conString);

        // Initialize command
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "UPDATE Movies SET Title=@Title,Director=@Director"
            + " WHERE Id=@original_Id AND Title=@original_Title AND Director=@original_Director";

        // Create parameters
        cmd.Parameters.AddWithValue("@Title", title);
        cmd.Parameters.AddWithValue("@Director", director);
        cmd.Parameters.AddWithValue("@original_Id", original_id);
        cmd.Parameters.AddWithValue("@original_Title", original_title);
        cmd.Parameters.AddWithValue("@original_Director", original_director);

        using (con)
        {
            con.Open();
            int rowsAffected = cmd.ExecuteNonQuery();
            if (rowsAffected == 0)
                throw new Exception("Could not update movie record");
        }
    }

    static ConflictedMovies()
    {
        _conString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }
}
