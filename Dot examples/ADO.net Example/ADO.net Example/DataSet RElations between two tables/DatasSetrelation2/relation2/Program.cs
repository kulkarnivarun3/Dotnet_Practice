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

        dcEmployees[0] = new DataColumn("FirstName",
                 System.Type.GetType("System.String"));
        dtEmployees.Columns.Add(dcEmployees[0]);
        dcEmployees[1] = new DataColumn("LastName",
                 System.Type.GetType("System.String"));
        dtEmployees.Columns.Add(dcEmployees[1]);
        dcEmployees[2] = new DataColumn("Department",
                 System.Type.GetType("System.String"));
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
        drEmplRecord["LastName"] = "Thoma";
        drEmplRecord["Department"] = "Public Relations";
        dtEmployees.Rows.Add(drEmplRecord);

        drEmplRecord = dtEmployees.NewRow();
        drEmplRecord["FirstName"] = "Bertha";
        drEmplRecord["LastName"] = "Um";
        drEmplRecord["Department"] = "Corporate";
        dtEmployees.Rows.Add(drEmplRecord);

        DataTable dtEmplStatus = new DataTable("EmploymentStatus");

        DataColumn dcEmployment = new DataColumn();
        dcEmployment = new DataColumn("EmplStatus",
                 System.Type.GetType("System.String"));
        dtEmplStatus.Columns.Add(dcEmployment);

        DataRow drEmployment = dtEmplStatus.NewRow();
        drEmployment["EmplStatus"] = "Full Time";
        dtEmplStatus.Rows.Add(drEmployment);

        drEmployment = dtEmplStatus.NewRow();
        drEmployment["EmplStatus"] = "Part Time";
        dtEmplStatus.Rows.Add(drEmployment);

        drEmployment = dtEmplStatus.NewRow();
        drEmployment["EmplStatus"] = "Contractor";
        dtEmplStatus.Rows.Add(drEmployment);

        drEmployment = dtEmplStatus.NewRow();
        drEmployment["EmplStatus"] = "Intern";
        dtEmplStatus.Rows.Add(drEmployment);

        dsEmployment.Tables.Add(dtEmplStatus);
        dsEmployment.Tables.Add(dtEmployees);

        Console.WriteLine("================+===============+===============");
        Console.WriteLine("First Name\t|Last Name\t|Department");
        Console.WriteLine("----------------+---------------+---------------");
        foreach (DataRow row in dsEmployment.Tables["Employees"].Rows)
            Console.WriteLine("{0}\t\t|{1}\t\t|{2}",
                              row["FirstName"], row["LastName"],
                              row["Department"]);
        Console.WriteLine("================+===============+===============\n");

        Console.WriteLine("=================");
        Console.WriteLine("Employment Status");
        Console.WriteLine("-----------------");
        foreach (DataRow row in dsEmployment.Tables["EmploymentStatus"].Rows)
            Console.WriteLine("{0}", row["EmplStatus"]);
        Console.WriteLine("=================");
        Console.WriteLine();
        Console.Read();
    }
}