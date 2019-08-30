using System;
using System.Xml;
using System.Data;

class Exercise
{
    static void Main()
    {
        DataSet dsEmployment = new DataSet();
        DataTable dtEmployees = new DataTable("Employees");

        DataColumn[] dcEmployees = new DataColumn[3];

        dcEmployees[0] = new DataColumn("FirstName", System.Type.GetType("System.String"));
        dtEmployees.Columns.Add(dcEmployees[0]);
        dcEmployees[1] = new DataColumn("LastName", System.Type.GetType("System.String"));
        dtEmployees.Columns.Add(dcEmployees[1]);
        dcEmployees[2] = new DataColumn("Department", System.Type.GetType("System.String"));
        dtEmployees.Columns.Add(dcEmployees[2]);

        DataRow drEmplRecord = dtEmployees.NewRow();
        drEmplRecord["FirstName"] = "Peter";
        drEmplRecord["LastName"] = "Larsen";
        drEmplRecord["Department"] = "Accounting";
        dtEmployees.Rows.Add(drEmplRecord);

        drEmplRecord = dtEmployees.NewRow();
        drEmplRecord["FirstName"] = "Paul";
        drEmplRecord["LastName"] = "Banack";
        drEmplRecord["Department"] = "IT/IM";
        dtEmployees.Rows.Add(drEmplRecord);

        drEmplRecord = dtEmployees.NewRow();
        drEmplRecord["FirstName"] = "Helene";
        drEmplRecord["LastName"] = "Casson";
        drEmplRecord["Department"] = "Accounting";
        dtEmployees.Rows.Add(drEmplRecord);

        drEmplRecord = dtEmployees.NewRow();
        drEmplRecord["FirstName"] = "Anselme";
        drEmplRecord["LastName"] = "Thomas";
        drEmplRecord["Department"] = "Public Rel";
        dtEmployees.Rows.Add(drEmplRecord);

        drEmplRecord = dtEmployees.NewRow();
        drEmplRecord["FirstName"] = "Bertha";
        drEmplRecord["LastName"] = "Colson";
        drEmplRecord["Department"] = "Corporate";
        dtEmployees.Rows.Add(drEmplRecord);

        dsEmployment.Tables.Add(dtEmployees);

        Console.WriteLine("============+===============+===============");
        Console.WriteLine("First Name  | Last Name     | Department");
        Console.WriteLine("------------+---------------+---------------");
        foreach (DataRow row in dsEmployment.Tables["Employees"].Rows)
        {
            Console.WriteLine("{0}\t    | {1}\t    | {2}",
                              row["FirstName"], row["LastName"],
                              row["Department"]);
        }
        Console.WriteLine("============+===============+===============\n");
        Console.Read();
    }
}