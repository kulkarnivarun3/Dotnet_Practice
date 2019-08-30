using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public class Movie
{
    public static ArrayList Search(string query)
    {
        ArrayList results = new ArrayList();
        string conString = WebConfigurationManager.ConnectionStrings["con"].ConnectionString;
        string commandText = "SELECT Title FROM Movie WHERE Title LIKE @query + '%'";
        SqlConnection con = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand(commandText, con);
        cmd.Parameters.AddWithValue("@query", query);
        using (con)
        {
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
                results.Add((string)reader["Title"]);
        }
        return results;
    }


}
