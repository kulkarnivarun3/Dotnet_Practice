using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Collections.Generic;

public class RandomDataLayer
{
    private static readonly string _connectionString;

    public List<String> GetRandomMovies()
    {
        List<String> results = new List<String>();
        SqlConnection con = new SqlConnection(_connectionString);
        SqlCommand cmd = new SqlCommand("GetRandomRows", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@rowsToReturn", 5);
        using (con)
        {
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
                results.Add((string)reader["Title"]);
        }
        return results;
    }


    public static string GetRandomMovie()
    {
        string result = String.Empty;
        SqlConnection con = new SqlConnection(_connectionString);
        SqlCommand cmd = new SqlCommand("GetRandomRow", con);
        cmd.CommandType = CommandType.StoredProcedure;
        using (con)
        {
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
                result = (string)reader["Title"];
        }
        return result;
    }

    static RandomDataLayer()
    {
        _connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }

}
