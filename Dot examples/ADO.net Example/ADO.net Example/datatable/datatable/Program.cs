using System;
using System.Data;

class Program
{
    static void Main()
    {
        
        DataTable table = GetTable();
        

        Console.WriteLine("\n printing first row of the table");
        DataRow row1 = table.Rows[0];
        Console.WriteLine(row1["Dosage"]);
        Console.WriteLine(row1[1]);

        //REad data from table1
        foreach (DataRow row in table.Rows)
        {
            foreach (DataColumn col in table.Columns)
                Console.WriteLine(row[col]);
            Console.WriteLine("".PadLeft(20, '='));
        }

        Console.Read();

    }

    
    static DataTable GetTable()
    {
        //
        // Here we create a DataTable with four columns.
        //
        DataTable table = new DataTable();
        table.Columns.Add("Dosage", typeof(int));
        table.Columns.Add("Drug", typeof(string));
        table.Columns.Add("Patient", typeof(string));
        table.Columns.Add("Date", typeof(DateTime));

        //
        // Here we add five DataRows.
        //
        table.Rows.Add(25, "Indocin", "David", DateTime.Now);
        table.Rows.Add(50, "Enebrel", "Sam", DateTime.Now);
        table.Rows.Add(10, "Hydralazine", "Christoff", DateTime.Now);
        table.Rows.Add(21, "Combivent", "Janet", DateTime.Now);
        table.Rows.Add(100, "Dilantin", "Melanie", DateTime.Now);
        return table;
    }
}