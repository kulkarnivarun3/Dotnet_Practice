using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public class MovieUIPaging
{
    private readonly string _conString;

    public DataSet GetMoviesDataSet()
    {
        // Create DataAdapter
        string commandText = "SELECT Id,Title,Director FROM Movies";
        SqlDataAdapter dad = new SqlDataAdapter(commandText, _conString);

        // Return DataSet
        DataSet dstMovies = new DataSet();
        using (dad)
        {
            dad.Fill(dstMovies);
        }
        return dstMovies;
    }

    public MovieUIPaging()
    {
        _conString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }
}
