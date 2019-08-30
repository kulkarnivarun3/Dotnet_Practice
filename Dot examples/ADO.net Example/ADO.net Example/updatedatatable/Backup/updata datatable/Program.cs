using System;
using System.Data;
using System.Data.SqlClient;

class MultipleDataTables
{
    public static void Main()
    {
        SqlConnection mySqlConnection = new SqlConnection(@"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\amg\Desktop\updatedatatable\updata datatable\bin\Debug\master.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True");

        SqlDataAdapter thisAdapter = new SqlDataAdapter("SELECT ID, Name FROM Employee", mySqlConnection);

        SqlCommandBuilder cmdBuilder = new SqlCommandBuilder(thisAdapter);
        DataSet thisDataSet = new DataSet();

        thisAdapter.Fill(thisDataSet, "Employee");

        Console.WriteLine("# rows before change: {0}", thisDataSet.Tables["Employee"].Rows.Count);

        DataRow thisRow = thisDataSet.Tables["Employee"].NewRow();
        thisRow["ID"] = "123";
        thisRow["Name"] = "Ltd";
        thisDataSet.Tables["Employee"].Rows.Add(thisRow);
       

        Console.WriteLine("# rows after change: {0}", thisDataSet.Tables["Employee"].Rows.Count);
        
        
        thisAdapter.Update(thisDataSet.Tables["Employee"]);
        //display two table data
        foreach (DataTable myDataTable in thisDataSet.Tables)
        {
            Console.WriteLine("\nReading from the " + myDataTable.TableName + "  DataTable");
            foreach (DataRow myDataRow in myDataTable.Rows)
            {
                foreach (DataColumn myDataColumn in myDataTable.Columns)
                {
                    Console.WriteLine(myDataColumn + "= " + myDataRow[myDataColumn]);
                }
            }
        }

        Console.Read();
    }
}