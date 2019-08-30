using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public class Message
{
    public string PostedBy { get; set; }

    public string Post { get; set; }
    
    public static ArrayList Select()
    {
        ArrayList results = new ArrayList();
        string conString = WebConfigurationManager.ConnectionStrings["con"].ConnectionString;
        string commandText = "SELECT PostedBy, Post FROM Message ORDER BY Id DESC";
        SqlConnection con = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand(commandText, con);
        using (con)
        {
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
                results.Add(new Message(reader));
        }
        return results;
    }


    public Message(SqlDataReader reader)
    {
        PostedBy = (string)reader["PostedBy"];
        Post = (string)reader["Post"];    
    }

}
