using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public class Guestbook
{
    private string _conString;

    public SqlDataReader GetEntries()
    {
        // Initialize connection     
        SqlConnection con = new SqlConnection(_conString);

        // Initialize command
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "SELECT Id,IPAddress,Comment,EntryDate FROM Guestbook";

        // Execute command
        con.Open();
        return cmd.ExecuteReader(CommandBehavior.CloseConnection);
    }

    public void AddEntry(string IPAddress, string comment)
    {
        // Initialize connection     
        SqlConnection con = new SqlConnection(_conString);

        // Initialize command
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "INSERT Guestbook (IPAddress,Comment)" +
            " VALUES (@IPAddress, @Comment)";

        // Add ADO.NET parameters
        cmd.Parameters.AddWithValue("@IPAddress", IPAddress);
        cmd.Parameters.AddWithValue("@Comment", comment);

        // Execute command
        using (con)
        {
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    public Guestbook()
    {
        _conString = WebConfigurationManager.ConnectionStrings["Guestbook"].ConnectionString;
    }

}
