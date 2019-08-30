using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public class GuestbookComponent
{
    private string _conString;

    public SqlDataReader GetEntries()
    {
        // Initialize connection     
        SqlConnection con = new SqlConnection(_conString);

        // Initialize command
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "SELECT Id,Username,Comment,EntryDate FROM Guestbook";

        // Execute command
        con.Open();
        return cmd.ExecuteReader(CommandBehavior.CloseConnection);
    }


    public void AddEntry(string username, string comment)
    {
        // Initialize connection     
        SqlConnection con = new SqlConnection(_conString);

        // Initialize command
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "INSERT Guestbook (Username,Comment)" +
            " VALUES (@Username, @Comment)";

        // Add ADO.NET parameters
        cmd.Parameters.AddWithValue("@Username", username);
        cmd.Parameters.AddWithValue("@Comment", comment);

        // Execute command
        using (con)
        {
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    public GuestbookComponent()
    {
        _conString = WebConfigurationManager.ConnectionStrings["Guestbook"].ConnectionString;
    }

}
