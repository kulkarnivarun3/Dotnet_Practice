using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Configuration;

public class Movie9
{
    private SqlDataAdapter dad = new SqlDataAdapter();

    public DataTable GetAll()
    {
        return (DataTable)HttpContext.Current.Session["MoviesToEdit"];
    }

    public void Update(int id, string title, string director)
    {
        DataTable movies = (DataTable)HttpContext.Current.Session["MoviestoEdit"];
        DataRow rowToEdit = movies.Rows.Find(id);
        rowToEdit["title"] = title;
        rowToEdit["director"] = director;
    }

    public void RejectChanges()
    {
        DataTable movies = (DataTable)HttpContext.Current.Session["MoviestoEdit"];
        movies.RejectChanges();
    }

    public void AcceptChanges()
    {
        DataTable movies = (DataTable)HttpContext.Current.Session["MoviestoEdit"];
        dad.Update(movies);
        movies.AcceptChanges();
    }

    public Movie9()
    {
        // Create Data Adapter
        string connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
        dad = new SqlDataAdapter("SELECT Id,Title,Director FROM Movies", connectionString);
        SqlCommandBuilder builder = new SqlCommandBuilder(dad);
        dad.UpdateBatchSize = 0;

        HttpContext context = HttpContext.Current;
        if (context.Session["MoviesToEdit"] == null)
        {
            // Add data to DataTable
            DataTable dtblMovies = new DataTable();
            dad.Fill(dtblMovies);
            dtblMovies.PrimaryKey = new DataColumn[] { dtblMovies.Columns["Id"] };
            context.Session["MoviesToEdit"] = dtblMovies;
        }
    }
}
