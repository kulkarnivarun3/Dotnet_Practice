using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Collections.Generic;

public class Movie5
{
    private static readonly string _connectionString;

    private string _title;
    private decimal _boxOfficeTotals;

    public string Title
    {
        get { return _title; }
        set { _title = value; }
    }

    public decimal BoxOfficeTotals
    {
        get { return _boxOfficeTotals; }
        set { _boxOfficeTotals = value; }
    }

    public List<Movie5> GetBoxOffice(out decimal SumBoxOfficeTotals)
    {
        List<Movie5> results = new List<Movie5>();
        SqlConnection con = new SqlConnection(_connectionString);
        SqlCommand cmd = new SqlCommand("GetBoxOfficeTotals", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@SumBoxOfficeTotals", SqlDbType.Money).Direction = ParameterDirection.Output;
        using (con)
        {
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Movie5 newMovie = new Movie5();
                newMovie.Title = (string)reader["Title"];
                newMovie.BoxOfficeTotals = (decimal)reader["BoxOfficeTotals"];
                results.Add(newMovie);
            }
            reader.Close();
            SumBoxOfficeTotals = (decimal)cmd.Parameters["@SumBoxOfficeTotals"].Value;

        }
        return results;
    }

    static Movie5()
    {
        _connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }
}
