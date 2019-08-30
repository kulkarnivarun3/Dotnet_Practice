using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public class EmployeesUISorting
{
    private static readonly string _conString;

    public static DataSet GetEmployees()
    {
        // Initialize ADO.NET objects
        string selectText = "SELECT Id,FirstName,LastName,Phone FROM Employees";
        SqlDataAdapter dad = new SqlDataAdapter(selectText, _conString);
        DataSet dstEmployees = new DataSet();

        // Fill the DataSet
        using (dad)
        {
            dad.Fill(dstEmployees);
        }
        return dstEmployees;
    }

    static EmployeesUISorting()
    {
        _conString = WebConfigurationManager.ConnectionStrings["Employees"].ConnectionString;
    }

}
