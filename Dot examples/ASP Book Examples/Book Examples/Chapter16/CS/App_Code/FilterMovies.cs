using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public class FilterMovies
{
    private readonly string _conString;

    public DataSet GetMovies()
    {
        // Initialize connection     
        SqlConnection con = new SqlConnection(_conString);

        // Initialize DataAdapter
        string commandText = "SELECT Title,Director,CategoryId FROM Movies";
        SqlDataAdapter dad = new SqlDataAdapter(commandText, con);

        // Return DataSet
        DataSet dstMovies = new DataSet();
        using (con)
        {
            dad.Fill(dstMovies);
        }
        return dstMovies;
    }

    public DataSet GetMovieCategories()
    {
        // Initialize connection     
        SqlConnection con = new SqlConnection(_conString);

        // Initialize DataAdapter
        string commandText = "SELECT Id,Name FROM MovieCategories";
        SqlDataAdapter dad = new SqlDataAdapter(commandText, con);

        // Return DataSet
        DataSet dstCategories = new DataSet();
        using (con)
        {
            dad.Fill(dstCategories);
        }
        return dstCategories;
    }

    public FilterMovies()
    {
        _conString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }
}
