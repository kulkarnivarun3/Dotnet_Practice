<%@ WebHandler Language="C#" Class="DynamicImage" %>

using System.Data;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

/// <summary>
/// Displays an image corresponding to the Id passed
/// in a query string field
/// </summary>
public class DynamicImage : IHttpHandler 
{
    
    public void ProcessRequest (HttpContext context) 
    {
        // Get the Id of the image to display
        string imageId = context.Request.QueryString["Id"];
        
        // Use SqlDataSource to grab image bytes
        SqlDataSource src = new SqlDataSource();
        src.ConnectionString = WebConfigurationManager.ConnectionStrings["Images"].ConnectionString;
        src.SelectCommand = "SELECT Image FROM Images WHERE Id=" + imageId;

        // Return a DataView
        
        DataView view = (DataView)src.Select(DataSourceSelectArguments.Empty);
        context.Response.BinaryWrite( (byte[])view[0]["Image"]);

        // Return a DataReader
        //src.DataSourceMode = SqlDataSourceMode.DataReader;
        //IDataReader reader = (IDataReader)src.Select(DataSourceSelectArguments.Empty);
        //reader.Read();
        //context.Response.BinaryWrite((byte[])reader["Image"]);
        //reader.Close();
        
    }
 
    public bool IsReusable 
    {
        get 
        {
            return false;
        }
    }

}