using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Collections.Generic;

public class DBDataLayer
{
    private static readonly string _connectionString;

    public List<DBMovie> GetAll()
    {
        List<DBMovie> results = new List<DBMovie>();
        SqlConnection con = new SqlConnection(_connectionString);
        SqlCommand cmd = new SqlCommand("SELECT Movie FROM DBMovies", con);
        using (con)
        {
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                DBMovie newMovie = (DBMovie)reader["Movie"];
                results.Add(newMovie);
            }
        }
        return results;
    }

    public void Insert(DBMovie movieToAdd)
    {
        SqlConnection con = new SqlConnection(_connectionString);
        SqlCommand cmd = new SqlCommand("INSERT DBMovies (Movie) VALUES (@Movie)", con);
        cmd.Parameters.Add("@Movie", SqlDbType.Udt);
        cmd.Parameters["@Movie"].UdtTypeName = "DBMovie";
        cmd.Parameters["@Movie"].Value = movieToAdd;
        using (con)
        {
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }


    static DBDataLayer()
    {
        _connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }
}
