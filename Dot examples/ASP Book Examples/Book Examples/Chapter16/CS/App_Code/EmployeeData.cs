using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web.Configuration;

public class EmployeeData
{
    string _connectionString;

    public void UpdateEmployee(CompanyEmployee employeeToUpdate)
    {
        // Initialize ADO.NET objects
        SqlConnection con = new SqlConnection(_connectionString);
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "UPDATE Employees SET FirstName=@FirstName," +
            "LastName=@LastName,Phone=@Phone WHERE Id=@Id";
        cmd.Connection = con;

        // Create parameters
        cmd.Parameters.AddWithValue("@Id", employeeToUpdate.Id);
        cmd.Parameters.AddWithValue("@FirstName", employeeToUpdate.FirstName);
        cmd.Parameters.AddWithValue("@LastName", employeeToUpdate.LastName);
        cmd.Parameters.AddWithValue("@Phone", employeeToUpdate.Phone);

        // Execute command
        using (con)
        {
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    public List<CompanyEmployee> GetEmployees()
    {
        List<CompanyEmployee> employees = new List<CompanyEmployee>();

        SqlConnection con = new SqlConnection(_connectionString);
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "SELECT Id,FirstName,LastName,Phone FROM Employees";
        cmd.Connection = con;
        using (con)
        {
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                CompanyEmployee newEmployee = new CompanyEmployee();
                newEmployee.Id = (int)reader["Id"];
                newEmployee.FirstName = (string)reader["FirstName"];
                newEmployee.LastName = (string)reader["LastName"];
                newEmployee.Phone = (string)reader["Phone"];
                employees.Add(newEmployee);
            }
        }
        return employees;
    }

    public EmployeeData()
    {
        _connectionString = WebConfigurationManager.ConnectionStrings["Employees"].ConnectionString;
    }
}

public class CompanyEmployee
{
    private int _id;
    private string _firstName;
    private string _lastName;
    private string _phone;

    public int Id
    {
        get { return _id; }
        set { _id = value; }
    }

    public string FirstName
    {
        get { return _firstName; }
        set { _firstName = value; }
    }

    public string LastName
    {
        get { return _lastName; }
        set { _lastName = value; }
    }

    public string Phone
    {
        get { return _phone; }
        set { _phone = value; }
    }
}
