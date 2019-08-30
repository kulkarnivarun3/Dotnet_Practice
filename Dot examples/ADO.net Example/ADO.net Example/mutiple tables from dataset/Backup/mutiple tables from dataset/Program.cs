using System;
using System.Data;
using System.Data.SqlClient;

class MultipleDataTables
{
    public static void Main()
    {
        string path = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);

        // The following is the database connection string
        string source = @"Data Source=.\SQLEXPRESS;AttachDbFilename=" + path + "\\master.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
        SqlConnection mySqlConnection = new SqlConnection(source);

        SqlCommand mySqlCommand = mySqlConnection.CreateCommand();
        mySqlCommand.CommandText =
          "SELECT * FROM Stud;" +
          "SELECT * FROM Employee;";

        SqlDataAdapter mySqlDataAdapter = new SqlDataAdapter();
        mySqlDataAdapter.SelectCommand = mySqlCommand;
        DataSet myDataSet = new DataSet();
        mySqlConnection.Open();
        int numberOfRows = mySqlDataAdapter.Fill(myDataSet);
        Console.WriteLine("numberOfRows = " + numberOfRows);
        mySqlConnection.Close();

        myDataSet.Tables["Table"].TableName = "Stud";
        myDataSet.Tables["Table1"].TableName = "Employee";
//display two table data
        foreach (DataTable myDataTable in myDataSet.Tables)
        {
            Console.WriteLine("\nReading from the " +
              myDataTable.TableName + "DataTable");
            foreach (DataRow myDataRow in myDataTable.Rows)
            {
                foreach (DataColumn myDataColumn in myDataTable.Columns)
                {
                    Console.WriteLine(myDataColumn + "= " +
                      myDataRow[myDataColumn]);
                }
            }
        }
       
        Console.Read();
    }
}