using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace AspNetUnleashed.Samples
{
    public class MovieDataSource : ObjectDataSource
    {
        public MovieDataSource()
        {
            this.TypeName = "AspNetUnleashed.Samples.MoviesComponent";
            this.SelectMethod = "GetMovies";
        }
    }

    public class MoviesComponent
    {
        private readonly string _conString;

        public SqlDataReader GetMovies()
        {
            // Initialize connection     
            SqlConnection con = new SqlConnection(_conString);

            // Initialize command
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = "SELECT Title,Director,DateReleased FROM Movies";

            // Execute command
            con.Open();
            return cmd.ExecuteReader(CommandBehavior.CloseConnection);
        }

        public MoviesComponent()
        {
            _conString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
        }
    }
}