using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public class MovieDataSet
{
    private readonly string _conString;

    public DataSet GetMovies()
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


    public MovieDataSet()
    {
        _conString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
    }
}
