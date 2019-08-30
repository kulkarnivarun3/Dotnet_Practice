using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public class EmployeesDSSorting
{
    private static readonly string _conString;

    public static SqlDataReader GetEmployees(string sortExpression, int startRowIndex, int maximumRows)
    {
        // Initialize connection     
        SqlConnection con = new SqlConnection(_conString);

        // Initialize command
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "GetSortedEmployees";
        cmd.CommandType = CommandType.StoredProcedure;

        // Create parameters
        cmd.Parameters.AddWithValue("@SortExpression", sortExpression);
        cmd.Parameters.AddWithValue("@StartRowIndex", startRowIndex);
        cmd.Parameters.AddWithValue("@MaximumRows", maximumRows);

        // Execute command
        con.Open();
        return cmd.ExecuteReader(CommandBehavior.CloseConnection);
    }

    public static int GetEmployeeCount()
    {
        HttpContext context = HttpContext.Current;
        if (context.Cache["EmployeeCount"] == null)
            context.Cache["EmployeeCount"] = GetEmployeeCountFromDB();
        return (int)context.Cache["EmployeeCount"];
    }

    private static int GetEmployeeCountFromDB()
    {
        int result = 0;

        // Initialize connection     
        SqlConnection con = new SqlConnection(_conString);

        // Initialize command
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "SELECT Count(*) FROM Employees";

        // Execute command
        using (con)
        {
            con.Open();
            result = (int)cmd.ExecuteScalar();
        }
        return result;
    }


    static EmployeesDSSorting()
    {
        _conString = WebConfigurationManager.ConnectionStrings["Employees"].ConnectionString;
    }

}
