using System;
using System.Data;

class Program
{
    static void Main()
    {
        // Create two DataTable instances.
        DataTable table1 = new DataTable("patients");
        table1.Columns.Add("name");
        table1.Columns.Add("id");
        table1.Rows.Add("sam", 1);
        table1.Rows.Add("mark", 2);

        DataTable table2 = new DataTable("medications");
        table2.Columns.Add("id");
        table2.Columns.Add("medication");
        table2.Rows.Add(1, "atenolol");
        table2.Rows.Add(2, "amoxicillin");

        // Create a DataSet and put both tables in it.
        DataSet set = new DataSet("office");
        set.Tables.Add(table1);
        set.Tables.Add(table2);

        // Visualize DataSet.
        Console.WriteLine(set.GetXml());
        
        //retrive name of table from data set
        DataTableCollection collection = set.Tables;
        for (int i = 0; i < collection.Count; i++)
        {
            DataTable table = collection[i];
            Console.WriteLine("{0}: {1}", i, table.TableName);
        }
        //REad data from table1
        foreach (DataRow row in table1.Rows)
        {
            foreach (DataColumn col in table1.Columns)
                Console.WriteLine(row[col]);
            Console.WriteLine("".PadLeft(20, '='));
        }
        //REad data from table2
        foreach (DataRow row in table2.Rows)
        {
            foreach (DataColumn col in table2.Columns)
                Console.WriteLine(row[col]);
            Console.WriteLine("".PadLeft(20, '='));
        }
        Console.Read();

    }
}