using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Collections.Generic;

public class Movie7
{
    private static readonly string _connectionString;

    public SqlDataReader GetAll()
    {
        SqlConnection con = new SqlConnection(_connectionString);
        SqlCommand cmd = new SqlCommand("SELECT Title,Director FROM Movies", con);
        con.Open();
        return cmd.ExecuteReader(CommandBehavior.CloseConnection);
    }

    static Movie7()
    {
        _connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }
}
